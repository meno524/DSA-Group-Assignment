import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string LIBRARYSYSTEM_DESC = "0A136C69627261727953797374656D2E70726F746F120E4C6962726172795061636B6167651A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F228B010A07416464426F6F6B12120A044953424E18012001280352044953424E12140A055469546C6518022001280952055469546C6512160A06417574686F721803200128095206417574686F72121A0A084C6F636174696F6E18042001280952084C6F636174696F6E12220A0C5374617475734F66426F6F6B180520012809520C5374617475734F66426F6F6B225F0A0741646455736572121C0A0953747564656E744944180120012803520953747564656E74494412200A0B53747564656E744E616D65180220012809520B53747564656E744E616D6512140A0550776F7264180320012809520550776F726422A6010A0A557064617465426F6F6B12140A05464953424E1801200128035205464953424E12140A054E4953424E18022001280352054E4953424E12140A055469546C6518032001280952055469546C6512160A06417574686F721804200128095206417574686F72121A0A084C6F636174696F6E18052001280952084C6F636174696F6E12220A0C5374617475734F66426F6F6B180620012809520C5374617475734F66426F6F6B22200A0A52656D6F7665426F6F6B12120A044953424E18012001280352044953424E2299010A154C697374416C6C417661696C61626C65426F6F6B7312120A044953424E18012001280352044953424E12140A055469546C6518022001280952055469546C6512160A06417574686F721803200128095206417574686F72121A0A084C6F636174696F6E18042001280952084C6F636174696F6E12220A0C5374617475734F66426F6F6B180520012809520C5374617475734F66426F6F6B223C0A0A4C6F63617465426F6F6B12120A044953424E18012001280352044953424E121A0A084C6F636174696F6E18022001280952084C6F636174696F6E2290010A0C4C697374416C6C426F6F6B7312120A044953424E18012001280352044953424E12140A055469546C6518022001280952055469546C6512160A06417574686F721803200128095206417574686F72121A0A084C6F636174696F6E18042001280952084C6F636174696F6E12220A0C5374617475734F66426F6F6B180520012809520C5374617475734F66426F6F6B2298010A144C697374416C6C426F72726F776564426F6F6B7312120A044953424E18012001280352044953424E12140A055469546C6518022001280952055469546C6512160A06417574686F721803200128095206417574686F72121A0A084C6F636174696F6E18042001280952084C6F636174696F6E12220A0C5374617475734F66426F6F6B180520012809520C5374617475734F66426F6F6B223F0A0B426F72726F77426F6F6B7312120A044953424E18012001280352044953424E121C0A0953747564656E744944180220012803520953747564656E74494422A2010A0C4C6F67696E4D65737361676512160A0649446E616D65180120012803520649446E616D6512100A037077641802200128095203707764121C0A097461626C654E616D6518032001280952097461626C654E616D6512220A0C4964636F6C756D6E4E616D65180420012809520C4964636F6C756D6E4E616D6512260A0E4E616D65636F6C756D6E4E616D65180520012809520E4E616D65636F6C756D6E4E616D65223F0A0B53686F774D65737361676512160A06666972737443180120012803520666697273744312180A075365636F6E644318022001280952075365636F6E644332F6050A074C69627261727912400A07616464426F6F6B12172E4C6962726172795061636B6167652E416464426F6F6B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512400A076164645573657212172E4C6962726172795061636B6167652E416464557365721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512460A0A757064617465426F6F6B121A2E4C6962726172795061636B6167652E557064617465426F6F6B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512460A0A72656D6F7665426F6F6B121A2E4C6962726172795061636B6167652E52656D6F7665426F6F6B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512580A156C697374416C6C417661696C61626C65426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A252E4C6962726172795061636B6167652E4C697374416C6C417661696C61626C65426F6F6B73300112460A0C6C697374416C6C426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A1C2E4C6962726172795061636B6167652E4C697374416C6C426F6F6B73300112560A146C697374416C6C426F72726F776564426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A242E4C6962726172795061636B6167652E4C697374416C6C426F72726F776564426F6F6B73300112480A0B626F72726F77426F6F6B73121B2E4C6962726172795061636B6167652E426F72726F77426F6F6B731A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565124B0A0C6C6F67696E4D657373616765121C2E4C6962726172795061636B6167652E4C6F67696E4D6573736167651A1B2E4C6962726172795061636B6167652E53686F774D657373616765300112460A0A6C6F63617465426F6F6B121A2E4C6962726172795061636B6167652E4C6F63617465426F6F6B1A1A2E4C6962726172795061636B6167652E4C6F63617465426F6F6B3001620670726F746F33";

public isolated client class LibraryClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARYSYSTEM_DESC);
    }

    isolated remote function addBook(AddBook|ContextAddBook req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        AddBook message;
        if req is ContextAddBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function addBookContext(AddBook|ContextAddBook req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        AddBook message;
        if req is ContextAddBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/addBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function addUser(AddUser|ContextAddUser req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        AddUser message;
        if req is ContextAddUser {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/addUser", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function addUserContext(AddUser|ContextAddUser req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        AddUser message;
        if req is ContextAddUser {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/addUser", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function updateBook(UpdateBook|ContextUpdateBook req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBook message;
        if req is ContextUpdateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function updateBookContext(UpdateBook|ContextUpdateBook req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBook message;
        if req is ContextUpdateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function removeBook(RemoveBook|ContextRemoveBook req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBook message;
        if req is ContextRemoveBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function removeBookContext(RemoveBook|ContextRemoveBook req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBook message;
        if req is ContextRemoveBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function borrowBooks(BorrowBooks|ContextBorrowBooks req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBooks message;
        if req is ContextBorrowBooks {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/borrowBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function borrowBooksContext(BorrowBooks|ContextBorrowBooks req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBooks message;
        if req is ContextBorrowBooks {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryPackage.Library/borrowBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function listAllAvailableBooks() returns stream<ListAllAvailableBooks, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/listAllAvailableBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ListAllAvailableBooksStream outputStream = new ListAllAvailableBooksStream(result);
        return new stream<ListAllAvailableBooks, grpc:Error?>(outputStream);
    }

    isolated remote function listAllAvailableBooksContext() returns ContextListAllAvailableBooksStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/listAllAvailableBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ListAllAvailableBooksStream outputStream = new ListAllAvailableBooksStream(result);
        return {content: new stream<ListAllAvailableBooks, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function listAllBooks() returns stream<ListAllBooks, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/listAllBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ListAllBooksStream outputStream = new ListAllBooksStream(result);
        return new stream<ListAllBooks, grpc:Error?>(outputStream);
    }

    isolated remote function listAllBooksContext() returns ContextListAllBooksStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/listAllBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ListAllBooksStream outputStream = new ListAllBooksStream(result);
        return {content: new stream<ListAllBooks, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function listAllBorrowedBooks() returns stream<ListAllBorrowedBooks, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/listAllBorrowedBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ListAllBorrowedBooksStream outputStream = new ListAllBorrowedBooksStream(result);
        return new stream<ListAllBorrowedBooks, grpc:Error?>(outputStream);
    }

    isolated remote function listAllBorrowedBooksContext() returns ContextListAllBorrowedBooksStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/listAllBorrowedBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ListAllBorrowedBooksStream outputStream = new ListAllBorrowedBooksStream(result);
        return {content: new stream<ListAllBorrowedBooks, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function loginMessage(LoginMessage|ContextLoginMessage req) returns stream<ShowMessage, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        LoginMessage message;
        if req is ContextLoginMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/loginMessage", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ShowMessageStream outputStream = new ShowMessageStream(result);
        return new stream<ShowMessage, grpc:Error?>(outputStream);
    }

    isolated remote function loginMessageContext(LoginMessage|ContextLoginMessage req) returns ContextShowMessageStream|grpc:Error {
        map<string|string[]> headers = {};
        LoginMessage message;
        if req is ContextLoginMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/loginMessage", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ShowMessageStream outputStream = new ShowMessageStream(result);
        return {content: new stream<ShowMessage, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function locateBook(LocateBook|ContextLocateBook req) returns stream<LocateBook, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        LocateBook message;
        if req is ContextLocateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/locateBook", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        LocateBookStream outputStream = new LocateBookStream(result);
        return new stream<LocateBook, grpc:Error?>(outputStream);
    }

    isolated remote function locateBookContext(LocateBook|ContextLocateBook req) returns ContextLocateBookStream|grpc:Error {
        map<string|string[]> headers = {};
        LocateBook message;
        if req is ContextLocateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("LibraryPackage.Library/locateBook", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        LocateBookStream outputStream = new LocateBookStream(result);
        return {content: new stream<LocateBook, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class ListAllAvailableBooksStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|ListAllAvailableBooks value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|ListAllAvailableBooks value;|} nextRecord = {value: <ListAllAvailableBooks>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public class ListAllBooksStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|ListAllBooks value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|ListAllBooks value;|} nextRecord = {value: <ListAllBooks>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public class ListAllBorrowedBooksStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|ListAllBorrowedBooks value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|ListAllBorrowedBooks value;|} nextRecord = {value: <ListAllBorrowedBooks>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public class ShowMessageStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|ShowMessage value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|ShowMessage value;|} nextRecord = {value: <ShowMessage>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public class LocateBookStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|LocateBook value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|LocateBook value;|} nextRecord = {value: <LocateBook>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextListAllAvailableBooksStream record {|
    stream<ListAllAvailableBooks, error?> content;
    map<string|string[]> headers;
|};

public type ContextListAllBorrowedBooksStream record {|
    stream<ListAllBorrowedBooks, error?> content;
    map<string|string[]> headers;
|};

public type ContextLocateBookStream record {|
    stream<LocateBook, error?> content;
    map<string|string[]> headers;
|};

public type ContextShowMessageStream record {|
    stream<ShowMessage, error?> content;
    map<string|string[]> headers;
|};

public type ContextListAllBooksStream record {|
    stream<ListAllBooks, error?> content;
    map<string|string[]> headers;
|};

public type ContextRemoveBook record {|
    RemoveBook content;
    map<string|string[]> headers;
|};

public type ContextListAllAvailableBooks record {|
    ListAllAvailableBooks content;
    map<string|string[]> headers;
|};

public type ContextAddUser record {|
    AddUser content;
    map<string|string[]> headers;
|};

public type ContextListAllBorrowedBooks record {|
    ListAllBorrowedBooks content;
    map<string|string[]> headers;
|};

public type ContextAddBook record {|
    AddBook content;
    map<string|string[]> headers;
|};

public type ContextLocateBook record {|
    LocateBook content;
    map<string|string[]> headers;
|};

public type ContextUpdateBook record {|
    UpdateBook content;
    map<string|string[]> headers;
|};

public type ContextLoginMessage record {|
    LoginMessage content;
    map<string|string[]> headers;
|};

public type ContextBorrowBooks record {|
    BorrowBooks content;
    map<string|string[]> headers;
|};

public type ContextShowMessage record {|
    ShowMessage content;
    map<string|string[]> headers;
|};

public type ContextListAllBooks record {|
    ListAllBooks content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type AddBook record {|
    int ISBN = 0;
    string TiTle = "";
    string Author = "";
    string Location = "";
    string StatusOfBook = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type LocateBook record {|
    int ISBN = 0;
    string Location = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type UpdateBook record {|
    int FISBN = 0;
    int NISBN = 0;
    string TiTle = "";
    string Author = "";
    string Location = "";
    string StatusOfBook = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type LoginMessage record {|
    int IDname = 0;
    string pwd = "";
    string tableName = "";
    string IdcolumnName = "";
    string NamecolumnName = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type RemoveBook record {|
    int ISBN = 0;
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type ListAllAvailableBooks record {|
    int ISBN = 0;
    string TiTle = "";
    string Author = "";
    string Location = "";
    string StatusOfBook = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type BorrowBooks record {|
    int ISBN = 0;
    int StudentID = 0;
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type ShowMessage record {|
    int firstC = 0;
    string SecondC = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type ListAllBooks record {|
    int ISBN = 0;
    string TiTle = "";
    string Author = "";
    string Location = "";
    string StatusOfBook = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type AddUser record {|
    int StudentID = 0;
    string StudentName = "";
    string Pword = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type ListAllBorrowedBooks record {|
    int ISBN = 0;
    string TiTle = "";
    string Author = "";
    string Location = "";
    string StatusOfBook = "";
|};

