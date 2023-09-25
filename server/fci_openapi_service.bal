import ballerina/http;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/sql;






listener http:Listener ep = new (8080, config = {host: "localhost"});



service /fci on ep {

      private final mysql:Client db;
  function init() returns error? {

    self.db = check new ( "localhost", "root", "Ninjakilla212","FCI",3306
);
    
     }   # Description
    #
    # + course - parameter description 
    # + return - returns can be any of following types
    # COURSE (Created)
    # InternalServerErrorErrorPayload (Internal server error)
    resource function post addcourse(@http:Payload COURSE course) returns COURSE|error {
         _=check self.db->execute(`
    INSERT INTO COURSE (course_code,course_name,NQF)
    VALUES (${course.course_code}, ${course.course_name}, ${course.NQF})`);
    

     return course; 
    }
    # Description
    #
    # + office - parameter description 
    # + return - returns can be any of following types
    # OFFICE (Created)
    # InternalServerErrorErrorPayload (Internal server error)
    resource function post office(@http:Payload OFFICE office) returns OFFICE|error {
         _=check self.db->execute(
      `INSERT INTO OFFICE (office_id ,office_number )
      VALUES(${office.office_ID},${office.office_number})`);

      return office;
    }
    # Description
    #
    # + office_ID - parameter description 
    # + return - returns can be any of following types
    # LECTURER[] (Ok)
    # InternalServerErrorErrorPayload (Internal server error)
  

       resource function get AllLecturersByOfficeid/[string office_ID]() returns LECTURER[]|error? {
        // Execute simple query to fetch record with requested id.
         sql:ParameterizedQuery result = `
SELECT 
    COALESCE(L.staff_number, -1) AS staff_number,
    COALESCE(L.staff_name, 'default_staff_name') AS staff_name,
    COALESCE(L.title, 'default_title') AS title,
    COALESCE(L.course_code, 'default_course_code') AS course_code,
    COALESCE(L.office_ID, -1) AS office_ID
FROM (
    SELECT ${office_ID} AS office_ID
) AS DefaultData
LEFT JOIN LECTURER AS L
ON DefaultData.office_ID = L.office_ID;

`;
         stream<LECTURER, error?> resultStream = self.db->query(result);
         return from LECTURER lecturerbyId in resultStream
         select lecturerbyId;
       
      

    }
  
       



    
    # Description
    #
    # + addlecturer - parameter description 
    # + return - returns can be any of following types
    # LECTURER (Created)
    # InternalServerErrorErrorPayload (Internal server error)
    resource function post addLecturer(@http:Payload LECTURER addlecturer) returns LECTURER|error {
         _=check self.db->execute(`
            INSERT INTO LECTURER (staff_number, staff_name, title, course_code, office_ID)
            VALUES (${addlecturer.staff_number }, ${addlecturer.staff_name}, ${addlecturer.title}, ${addlecturer.course_code}, ${addlecturer.office_ID})`);
       
        return addlecturer;
    }
    # Description
    #
    # + return - returns can be any of following types
    # LECTURER[] (Ok)
    # InternalServerErrorErrorPayload (Internal server error)
    resource function get allLecturers() returns LECTURER[]|error? {
         // Execute a query to retrieve all records from the `LECTURER` table.
  sql:ParameterizedQuery  result =`SELECT * FROM LECTURER`;
   
     stream<LECTURER, error?> resultStream = self.db->query(result);
        return from LECTURER lecturer in resultStream
        select lecturer;


 

   
   
    }

    # Description
    #
    # + course_code - parameter description 
    # + return - returns can be any of following types
    # LECTURER[] (Ok)
    # InternalServerErrorErrorPayload (Internal server error)
    resource function get AllLecturersByCourseCode/[string course_code]() returns LECTURER[]|error {
           // Execute simple query to fetch record with requested id.
               sql:ParameterizedQuery result = `

SELECT 
    COALESCE(L.staff_number, -1) AS staff_number,
    COALESCE(L.staff_name, 'default_staff_name') AS staff_name,
    COALESCE(L.title, 'default_title') AS title,
    COALESCE(L.course_code, 'default_course_code') AS course_code,
    COALESCE(L.office_ID, -1) AS office_ID
FROM (
    SELECT ${course_code} AS course_code
) AS DefaultData
LEFT JOIN LECTURER AS L
ON DefaultData.course_code = L.course_code;






`;
         stream<LECTURER, error?> resultStream = self.db->query(result);
         return from LECTURER lecturerbyId in resultStream
         select lecturerbyId;
       
      
    }
    
    # Description
    #
    # + updatelecturer - parameter description 
    # + return - returns can be any of following types
    # LECTURER (Ok)
    # InternalServerErrorErrorPayload (Internal server error)
    resource function put updateLecturerDetails/[string staff_number](LECTURER updatelecturer) returns  LECTURER|http:NotFound|error {
         _ = check self.db->execute(`
            UPDATE LECTURER
            SET staff_name = ${updatelecturer.staff_name}, 
                title = ${updatelecturer.title}, course_code = ${updatelecturer.course_code}, office_ID = ${updatelecturer.office_ID}
            WHERE staff_number = ${updatelecturer.staff_number}
        `);
       return updatelecturer;
    }
    
    # Description
    # + staff_number - parameter description
    # + return - returns can be any of following types
    # LecturerID (Ok)
    # InternalServerErrorErrorPayload (Internal server error)
   
       resource function delete Lecturer/[string staff_number]() returns string|http:NotFound|error {
      sql:ExecutionResult result = check self.db->execute(`DELETE FROM LECTURER WHERE staff_number = ${staff_number}`);
          if result.affectedRowCount>0{
            return ("Success");
        } else{
            return http:NOT_FOUND;
        }
    }
    
  
    
}
