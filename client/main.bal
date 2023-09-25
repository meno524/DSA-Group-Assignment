import ballerina/http;
import ballerina/io;
public type InternalServerErrorErrorPayload record {|
    *http:InternalServerError;
    ErrorPayload body;
|};

public type ErrorPayload record {
    # Reason phrase
    string reason?;
    # Request path
    string path?;
    # Method type of the request
    string method?;
    # Error message
    string message?;
    # Timestamp of the error
    string timestamp?;
    # Relevant HTTP status code
    int:Signed32 status?;
};

public type OFFICE record {
    int office_ID;
    string office_number;
};

public type LECTURER record {
    int staff_number;
    string staff_name;
    string title;
    string course_code;
    int office_ID;
};

public type LecturerID record {
    int staff_number;
};

public type COURSE record {
    string course_code?;
    string course_name?;
    int NQF?;
};

type lecturerID record {
    int staff_number;
    
};
public function main()returns  error? {
string option ="10";
 while(option !="0"){
  io:println("*****Welcome To FCI! Choose what to do*******\n" +
                                                 "Enter 1 to Add course\n" +
                                                 "Enter 2 to Add office\n" +
                                                 "Enter 3 to Display lecturers by officeID\n" +
                                                 "Enter 4 to Add Lecturer\n" +
                                                 "Enter 5 to Display all lecturers\n" +
                                                 "Enter 6 to Display lecturers by course Code\n" +
                                                 "Enter 7 to Update a Lecturer's details\n" +
                                                 "Enter 8 to Delete a lecturer's record\n" +
                                                "Enter  0 to exit");
                                                 option = io:readln("Enter choice here: ");

   
   match option {
     "0" => {
                       io:println("Goodbye, exiting main menu.");
                       break; }
    "1" => {
         check AddCourse();
    }
    "2"=>{check AddOffice();
    }

    "3"=>{check GetAllLecturersByOfficeID();
    }
    
    "4"=>{check AddLecturer();
    }

    "5"=>{check GetAllLecturers();
    }
    "6"=>{check GetAllLecturersByCourseCode();
    }
    "7"=>{check UpdateLecturer();
    }
    "8"=>{check  deleteLecturer();
    }
   }
}
}

function AddCourse() returns error? {
    http:Client cli =check new("localhost:8080");
    string course_code = io:readln("Enter the course code");
    string course_name = io:readln("Enter the course name");
   string NQF = io:readln("Enter the NQF");    
    int NQF1= check int:fromString(NQF );
   
   COURSE c1=check cli->/fci/addcourse.post({course_code:course_code,course_name:course_name,NQF:NQF1});
   io:println("\n Details posted successfully :",c1.toJsonString());
    
}


function AddOffice() returns error? {
    http:Client cli =check new("localhost:8080");
      string office_ID = io:readln("Enter the office_ID");    
    int officeID= check int:fromString(office_ID );
    string office_number = io:readln("Enter the office number");
 
   
   OFFICE c1=check cli->/fci/office.post({office_ID:officeID,office_number:office_number});
   io:println("\n Details posted successfully :",c1.toJsonString());
    
}


function GetAllLecturersByOfficeID() returns error? {
    http:Client cli =check new("localhost:8080");
    string office_ID = io:readln("Enter the office_ID");  
   int officeid= check int:fromString(office_ID);
 
   
   json[] c1=check cli->/fci/AllLecturersByOfficeid/[ officeid].get();
   
    if(c1[0].staff_number !=-1){  
        io:println(c1);}
        else{io:println("No staff with that number");}
        
    
  }


function GetAllLecturersByCourseCode() returns error? {
    http:Client cli =check new("localhost:8080");
    string course_code = io:readln("Enter the course code");
   
 
   
   json[] c1=check cli->/fci/AllLecturersByCourseCode/[ course_code].get();
    
    if(c1[0].staff_number !=-1){  
        io:println(c1);}
        else{io:println("No course code with that number");}
        
    
}




function GetAllLecturers() returns error? {
    http:Client cli = check new("http://localhost:8080"); // Make sure to include "http://"

    // Make the HTTP GET request
      json c1=check cli->/fci/allLecturers.get();
      io:println(c1);

  
}

function AddLecturer() returns error? {
    http:Client cli =check new("localhost:8080");
    string staff_number = io:readln("Enter the staff number");
     int staff_no = check int:fromString(staff_number );
    string staff_name = io:readln("Enter the staff name");
   string title = io:readln("Enter the title. e.g 'Mr'");    
    string course_code = io:readln("Enter the course code"); 
     string office_ID = io:readln("Enter the office id"); 
     int officeID = check int:fromString(office_ID );

   
   LECTURER c1=check cli->/fci/addLecturer.post({staff_number:staff_no,staff_name:staff_name,title:title,course_code:course_code,office_ID:officeID});
   io:println("\n Details posted successfully :",c1.toJsonString());
    
}


function deleteLecturer() returns error?{
        http:Client cli =check new("localhost:8080");
        string staff_number = io:readln("Enter the staff number");
        int staff_no = check int:fromString(staff_number );
        
     string c1=check cli->/fci/Lecturer/[staff_no].delete({staff_number:staff_no});
        io:println("\n  deleted successfully :",c1);

}


function UpdateLecturer() returns error?{
        http:Client cli =check new("localhost:8080");
        string staff_number = io:readln("Enter the staff number");
        int staff_no = check int:fromString(staff_number );
          string staff_name = io:readln("Enter the staff name");
   string title = io:readln("Enter the title. e.g 'Mr'");    
    string course_code = io:readln("Enter the course code"); 
     string office_ID = io:readln("Enter the office id"); 
     int officeID = check int:fromString(office_ID );
     
        
        LECTURER c1=check cli->/fci/updateLecturerDetails/[staff_no].put({staff_number:staff_no,staff_name:staff_name,title:title,course_code:course_code,office_ID:officeID});
        io:println("\n  Updated successfully :",c1.toJsonString());

}


 



