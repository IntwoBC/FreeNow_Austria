// report 50002 FN_UpdateNewGLEntry
// {
//     ApplicationArea = All;
//     Caption = 'Update New GLEntry';
//     UsageCategory = Lists;
//     ProcessingOnly = true;
//     Permissions = tabledata "G/L Entry" = RIMD;
//     dataset
//     {
//         dataitem(GLEntry; "G/L Entry")
//         {
//             RequestFilterFields = "Entry No.";
//             DataItemTableView = sorting("Updated New GL Entry") where("Updated New GL Entry" = const(False));
//             trigger OnAfterGetRecord()
//             var
//                 NewGLEntry: Record "I2I G/L Entry";
//                 RecGLENtry: Record "G/L Entry";
//             begin
//                 NewGLEntry.Init();
//                 NewGLEntry.TransferFields(GLEntry);
//                 NewGLEntry."Entry No." := GLEntry."Entry No."; // Ensure Entry No. is set
//                 NewGLEntry.Insert();
//                 if RecGLENtry.Get(GLEntry."Entry No.") then begin
//                     RecGLENtry."Updated New GL Entry" := true;
//                     RecGLENtry.Modify();
//                 end;
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {

//                 }
//             }
//         }
//         actions
//         {
//             area(Processing)
//             {
//             }
//         }
//     }
// }
