tableextension 50201 tableextension50201 extends "Resource Location"
{
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Location Code","Resource No.","Starting Date"(Key)".

        /*key(Key1; "Location Code", "Starting Date")
        {
            Clustered = true;
        }*///SPS
        key(Key2; "Resource No.", "Starting Date")
        {
        }
    }
}

