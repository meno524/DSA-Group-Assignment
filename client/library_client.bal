import ballerina/io;

LibraryClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    io:println("****** Library App ********");

    while (true) {
        string option = io:readln("Enter 1 to Login or 2 to SignUp: ");

        match option {
            "1" => {
                string intResultLogin = check Login();
                match intResultLogin {
                    "1" => { // Librarian
                        string LibrarianChoice = "";

                       while (LibrarianChoice != "0") {
                       io:println("******Welcome Librarian! Choose what to do********\n" +
                                                 "Enter 1 to Add book\n" +
                                                 "Enter 2 to Edit book\n" +
                                                 "Enter 3 to List all library books\n" +
                                                 "Enter 4 to List books that are not on loan\n" +
                                                 "Enter 5 to List books that are on loan\n" +
                                                 "Enter 6 to locate a book\n" +
                                                 "Enter 7 to Remove a book\n" +
                                                 "Enter 8 to borrow a book\n" +
                                                "Enter 0 to exit");

                            LibrarianChoice = io:readln("Enter choice here: ");

                            
                                 match LibrarianChoice {
                                 "1" => {check Addbooks();}
                                 "2" => {check UpdateBooks();}
                                 "3" => {check SeeAllBooks();}
                                 "4" => {check SeeAllFreeBooks();}
                                 "5" => {check SeeAllBorrowedBooks();}
                                 "6" => {check FindbookLocation();}
                                 "7" => {check RemoveABook();}
                                 "8" => {check BorrowABook();}
                                // Handle other librarian menu options
                                "0" => {
                                    io:println("Goodbye, exiting the librarian menu.");
                                    break; // Exit the librarian menu
                                }
                                _ => {
                                    io:println("Invalid choice. Please try again.");
                                }
                            }
                        }
                    }
                    "2" => { // Student
                        string StudentChoice = "";

                         while (StudentChoice != "0") {
                         io:println("******Welcome Student! Choose what to do********\n" +
                                                 "Enter 1 to List all library books\n" +
                                                 "Enter 2 to List books that are not on loan\n" +
                                                 "Enter 3 to List books that are on loan\n" +
                                                 "Enter 4 to locate a book\n" +
                                                 "Enter 5 to borrow a book\n" +
                                                 "Enter 0 to exit");

                            StudentChoice = io:readln("Enter choice here: ");

                             match StudentChoice {
                                  "1" => {check SeeAllBooks();}
                                  "2" => {check SeeAllFreeBooks();}
                                  "3" => {check SeeAllBorrowedBooks();}
                                  "4" => {check FindbookLocation();}
                                  "5" => {check BorrowABook();}
                                  "0" => {
                                  io:println("Goodbye, exiting the student menu.");
                                    break; // Exit the student menu
                                }
                                _ => {
                                    io:println("Invalid choice. Please try again.");
                                }
                            }
                        }
                    }
                    _ => {
                        io:println("Invalid login. Please try again.");
                    }
                }
            }
            "2" => {
                int intResultAddUser = check AddUsers();
                match intResultAddUser {
                    1 => {
                        io:println("****** You Can Now Login********");
                        // Continue to the main menu
                    }
                    _ => {
                        io:println("User registration failed. Please try again.");
                    }
                }
            }
            "0" => {
                       io:println("Goodbye, exiting main menu.");
                       break; // Exit the student menu
                                }
            _ => {
                io:println("Invalid choice. Please try again.");
            }
        }
        
    }   
}


    function Addbooks() returns error? {
    string ISBN = io:readln("Enter the ISBN");    
    int ISBN1= check int:fromString(ISBN );
    string TiTle1 = io:readln("Enter the Title");
    string Author1 = io:readln("Enter the Author name");
    string Location1 = io:readln("Enter the Book location");
    string StatusOfBook1 = io:readln("Enter the Status of the book");
    

    AddBook addBookRequest = {ISBN: ISBN1, TiTle: TiTle1, Author: Author1, Location: Location1, StatusOfBook: StatusOfBook1};
    string addBookResponse = check ep->addBook(addBookRequest);
    io:println(addBookResponse);}

    function AddUsers() returns int|error {
    string idString= io:readln("Enter your id");
    int id = check int:fromString(idString);
    string nameString= io:readln("Enter your name");
    string pdString= io:readln("Enter your password");
    AddUser addUserRequest = {StudentID: id, StudentName: nameString, Pword: pdString};
    string|error addUserResponse = check ep->addUser(addUserRequest);
    io:println(addUserResponse);
    if(addUserResponse is string){
        return 1;
    }else {
        return AddUsers(); 
    }
    }

    function UpdateBooks() returns error? {
    //Intialization of flieds and logic
    string ISBN = io:readln("Enter the ISBN of the book to UPDATE");    
    int ISBN1= check int:fromString(ISBN );
    string NISBN = io:readln("Enter the new ISBN of book or leave empty to not update");
    int NISBN1;
    if(NISBN==""){NISBN1=ISBN1;}else{NISBN1= check int:fromString(NISBN );}
    string TiTle1="";
    string Author1="";
    string Location1="";
    string StatusOfBook1="";
    TiTle1 =io:readln("Enter the new Title or leave empty to not update");
    Author1 = io:readln("Enter the new Author name or leave empty to not update");
    Location1 = io:readln("Enter the new Book location or leave empty to not update");
    StatusOfBook1 = io:readln("Enter the new Status of the book or leave empty to not update");

    UpdateBook updateBookRequest = {FISBN: ISBN1, NISBN: NISBN1,TiTle: TiTle1, Author: Author1, Location: Location1, StatusOfBook: StatusOfBook1};
    //End Of Intialization of flieds and logic
    string updateBookResponse = check ep->updateBook(updateBookRequest);
    io:println(updateBookResponse);}

    function RemoveABook() returns error? {
    //INTIALIZE VARIABLES
    string ISBN = io:readln("Enter the ISBN of the book to DELETE");    
    int ISBN1= check int:fromString(ISBN );
    RemoveBook removeBookRequest = {ISBN: ISBN1};
    string removeBookResponse = check ep->removeBook(removeBookRequest);
    io:println(removeBookResponse);}

    function BorrowABook() returns error? { 
    string ISBN = io:readln("Enter the ISBN of the book you want to borrow");    
    int ISBN1= check int:fromString(ISBN );
    string StrinStdId = io:readln("Enter your UserID");    
    int IntStdId= check int:fromString(StrinStdId );
    BorrowBooks borrowBooksRequest = {ISBN: ISBN1, StudentID: IntStdId};
    string borrowBooksResponse = check ep->borrowBooks(borrowBooksRequest);
    io:println(borrowBooksResponse);}

    function Login() returns string|error {
  ///Initialization of parameteres and main calling of Sever Side   
    string userType = io:readln("Enter 1 if your a Librarian or 2 to Student: ");
    int userytpeId = check int:fromString(userType);
    string columnNameId;
    string columnNameName;
    if(userytpeId==1){ userType="librarians"; columnNameId="LibrarianID";columnNameName="Pword";}
    else{userType="student";columnNameId="StudentID";columnNameName="Pword";}
    string idString= io:readln("Enter your id: ");
    int id = check int:fromString(idString);
    string pdString= io:readln("Enter your password: ");
    LoginMessage loginMessageRequest = {IDname: id, pwd: pdString, tableName: userType,IdcolumnName: columnNameId, NamecolumnName: columnNameName};
  ///Initialization of parameteres and main calling of Sever Side ///Login verification
   stream<ShowMessage, error?> loginMessageResponse = check ep->loginMessage(loginMessageRequest);
    int confirmationbool=0;
   check loginMessageResponse.forEach(function(ShowMessage value) {
          if(value.firstC==id){ 
          io:println("Successfuly logged in ");  
          }
          else{io:println("Failed to login "); confirmationbool=1;}
    });
 ///End of login Verification

 ///Deciding who the user is their privalleges
    if(confirmationbool==0 && userType=="librarians"){
        return "1";
    }
    
    else if(confirmationbool==0 && userType=="student"){return "2";}
    else{
        return Login(); 
    }
///End Deciding who the user is their privalleges
    }
    function SeeAllFreeBooks() returns error? {
    stream<ListAllAvailableBooks, error?> listAllAvailableBooksResponse = check ep->listAllAvailableBooks();
    check listAllAvailableBooksResponse.forEach(function(ListAllAvailableBooks value) {
        if(value.StatusOfBook=="Available"){  
        io:println(value);}
        else{io:println("No Available books at the mmoment");}
        }
    );}

    function SeeAllBooks() returns error? {
    stream<ListAllBooks, error?> listAllBooksResponse = check ep->listAllBooks();
    check listAllBooksResponse.forEach(function(ListAllBooks value) {
        io:println(value);
    });}

   function SeeAllBorrowedBooks() returns error? {
    stream<ListAllBorrowedBooks, error?> listAllBorrowedBooksResponse = check ep->listAllBorrowedBooks();
    check listAllBorrowedBooksResponse.forEach(function(ListAllBorrowedBooks value) {
        if(value.StatusOfBook=="Not Available"){  
        io:println(value);}
        else{io:println("No books on loan");}
    });}

    function FindbookLocation() returns error? {
    string ISBN = io:readln("Enter the ISBN of the book to find its location");    
    int ISBN1= check int:fromString(ISBN );
    LocateBook locateBookRequest = {ISBN: ISBN1};
    stream<LocateBook, error?> locateBookResponse = check ep->locateBook(locateBookRequest);
    check locateBookResponse.forEach(function(LocateBook value) {
        //io:println(value.Location);
        if(value.Location=="default_Location"){  
            io:println("The book is on loan");
       }
        else{ io:println("Book is found in "+value.Location);}
    });}