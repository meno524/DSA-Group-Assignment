import ballerina/grpc;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable  string USER = "root";
configurable  string PASSWORD = "root";
configurable  string HOST = "localhost";
configurable  int PORT = 3306;
configurable  string DATABASE = "library";


final mysql:Client dbClient = check new(
    host=HOST, user=USER, password=PASSWORD, port=PORT, database="library"
);


listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARYSYSTEM_DESC}
service "Library" on ep {
    

    remote function addBook(AddBook value) returns string|error {
    ///SQL TO ADD A BOOK TO THE DATABSE
       sql:ExecutionResult result = check dbClient->execute(`INSERT INTO book
        VALUES (${value.ISBN},${value.TiTle},${value.Author},${value.Location},${value.StatusOfBook})`);

         if result.affectedRowCount>0{
         return ("Succesfuly added book");
       } else {
        return error("Failed to add book");
        
    }
    }

    remote function addUser(AddUser value) returns string|error {
          sql:ExecutionResult result = check dbClient->execute(`INSERT INTO student
            VALUES (${value.StudentID},${value.StudentName},${value.Pword})`);

         if result.affectedRowCount>0{
         return ("Succesfuly added user");
       } else {
        return error("Failed to add user ");
        
    }
    }
    
remote function updateBook(UpdateBook value) returns string|error {
    sql:ParameterizedQuery TitleQeury= ``;
    sql:ParameterizedQuery AuthorQeury= ``;
    sql:ParameterizedQuery LocationQeury= ``;
    sql:ParameterizedQuery StatusOfBookQeury= ``;
    sql:ParameterizedQuery ISBNQeury= ``;
    sql:ExecutionResult  Title_Result;
    sql:ExecutionResult  Author_Result;
    sql:ExecutionResult  Location_Result;
    sql:ExecutionResult  StatusOfBook_Result;
    sql:ExecutionResult  ISBN_Result;
    int checkValue=0;



     if(value.TiTle!=""){
              TitleQeury =`UPDATE book
              SET
              TiTle = ${value.TiTle}
              WHERE
              ISBN = ${value.FISBN};`;
              Title_Result = check dbClient->execute(TitleQeury);
              if (Title_Result.affectedRowCount>0){
             
             } else {
             checkValue=1; }
}

      if(value.Author!=""){
              AuthorQeury =`UPDATE book
              SET
              Author = ${value.Author}
              WHERE
              ISBN = ${value.FISBN};`;
              Author_Result = check dbClient->execute(AuthorQeury);
              if (Author_Result.affectedRowCount>0){
             
             } else {
             checkValue=1; }
}


      if(value.Location!=""){
              LocationQeury =`UPDATE book
              SET
              Location = ${value.Location}
              WHERE
              ISBN = ${value.FISBN};`;
              Location_Result = check dbClient->execute(LocationQeury);
              if (Location_Result.affectedRowCount>0){
             
             } else {
             checkValue=1; }
              }  

      if(value.StatusOfBook!=""){
              StatusOfBookQeury =`UPDATE book
              SET
              StatusOfBook = ${value.StatusOfBook}
              WHERE
              ISBN = ${value.FISBN};`;
              StatusOfBook_Result = check dbClient->execute(StatusOfBookQeury);
              if (StatusOfBook_Result.affectedRowCount>0){
             
             } else {
             checkValue=1; }
              }    

     if(value.NISBN!=value.FISBN){
              ISBNQeury =`UPDATE book
              SET
              ISBN = ${value.NISBN}
              WHERE
              ISBN = ${value.FISBN};`;
              ISBN_Result = check dbClient->execute(ISBNQeury);
              if (ISBN_Result.affectedRowCount>0){
             
             } else {
             checkValue=1; }
             }              






    if (checkValue<1){
         return ("Succesfuly Updated book");
       } else {
        return error("Failed to Updated book ");
        
    }
    }


    remote function removeBook(RemoveBook value) returns string|error {
        sql:ExecutionResult result = check dbClient->execute(`
        DELETE FROM book WHERE ISBN = ${value.ISBN}`);

         if result.affectedRowCount>0{
         return ("Succesfuly Removed book");
       } else {
        return error("Failed to Remove book");
         }
      

    }
    remote function borrowBooks(BorrowBooks value) returns string|error {
  
          sql:ExecutionResult result = check dbClient->execute(`UPDATE book
              SET
              StatusOfBook = "Not Available"
              WHERE
              ISBN = ${value.ISBN}
              AND StatusOfBook = "Available"`);

         if result.affectedRowCount>0{
         return ("You have successfully loaned the Book");
       } else {
        return ("The book is already on loan ");
        
    }
    }
   remote function loginMessage(LoginMessage value) returns stream<ShowMessage, error?>|error {
    ///SQL TO ANUTHENTICATE USERS
     sql:ParameterizedQuery result= ``;
     if(value.tableName =="student"){
             result =(`
            SELECT
                 IF(COUNT(*) > 0, StudentID, -1) as firstC,
                 IF(COUNT(*) > 0, Pword, 'NotFound') as SecondC
            FROM
                student
            WHERE
                StudentID = ${value.IDname}
            AND 
               Pword = ${value.pwd}
                Limit 1; `);}
        else{
             result =(`
            SELECT
                 IF(COUNT(*) > 0, LibrarianID, -1) as firstC,
                 IF(COUNT(*) > 0, Pword, 'NotFound') as SecondC
            FROM
                librarians
            WHERE
                LibrarianID = ${value.IDname}
            AND 
               Pword = ${value.pwd}
                Limit 1; `);
        }
        stream<ShowMessage, error?> resultStream = dbClient->query(result);
        return resultStream;
    
    }
    remote function listAllAvailableBooks() returns stream<ListAllAvailableBooks, error?>|error {
     sql:ParameterizedQuery  result =(`
           SELECT
              ISBN,
              Title,
              Author,
              Location,
              StatusOfBook
           FROM
             book
          WHERE
          StatusOfBook = "Available"

          UNION ALL

          SELECT 
          -1            AS ISBN,
      'default_Title' AS Title,
       'default_Author' AS Author,
      'default_Location' AS Location,
       'default_StatusOfBook' AS StatusOfBook
      WHERE 
        NOT EXISTS (
      SELECT 1 FROM book WHERE StatusOfBook = "Available"
   );
`);
        stream<ListAllAvailableBooks, error?> resultStream = dbClient->query(result);
        return resultStream;
    }
    remote function listAllBooks() returns stream<ListAllBooks, error?>|error  {
    ///Query all available books
    sql:ParameterizedQuery query = `select * from book`;
    stream<ListAllBooks, error?> resultStream = dbClient->query(query);
    return resultStream;

    }
    remote function listAllBorrowedBooks() returns stream<ListAllBorrowedBooks, error?>|error {
         sql:ParameterizedQuery  result =(`
           SELECT
              ISBN,
              Title,
              Author,
              Location,
              StatusOfBook
           FROM
             book
          WHERE
          StatusOfBook = "Not Available"

          UNION ALL

          SELECT 
          -1            AS ISBN,
      'default_Title' AS Title,
       'default_Author' AS Author,
      'default_Location' AS Location,
       'default_StatusOfBook' AS StatusOfBook
      WHERE 
        NOT EXISTS (
      SELECT 1 FROM book WHERE StatusOfBook = "Not Available"
   );
`);
        stream<ListAllBorrowedBooks, error?> resultStream = dbClient->query(result);
        return resultStream;
    }

    remote function locateBook(LocateBook value) returns stream<LocateBook, error?>|error {
    sql:ParameterizedQuery result= `SELECT 
    Location
FROM book
WHERE ISBN = ${value.ISBN}
AND StatusOfBook = "Available"

UNION ALL

SELECT 
    'default_Location' AS Location
WHERE NOT EXISTS (
    SELECT 1 
    FROM book 
    WHERE ISBN = ${value.ISBN}
    AND StatusOfBook = "Available"
);`;
    stream<LocateBook, error?> resultStream = dbClient->query(result);
    return resultStream;

    }
}