codeunit 60035 Security
{

    trigger OnRun()
    begin
    end;

    //[Scope('Internal')]
    procedure Process(Users: XMLport Security)
    begin
        Users.Import;
    end;
}

