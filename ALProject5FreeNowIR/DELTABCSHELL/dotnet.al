
/*dotnet
{
    assembly("XLSXWrapperSAX")
    {
        Version = '1.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("XLSXWrapperSAX.XLSXWrapperSAX"; "XLSXWrapperSAX")
        {
        }
    }

    assembly("Microsoft.Office.Interop.Excel")
    {
        Version = '15.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '71e9bce111e9429c';

        type("Microsoft.Office.Interop.Excel.ApplicationClass"; "ApplicationClass")
        {
        }

        type("Microsoft.Office.Interop.Excel.Workbook"; "Workbook")
        {
        }

        type("Microsoft.Office.Interop.Excel.XlFileFormat"; "XlFileFormat")
        {
        }

        type("Microsoft.Office.Interop.Excel.XlSaveAsAccessMode"; "XlSaveAsAccessMode")
        {
        }
    }

    assembly("Microsoft.Dynamics.Nav.Integration.Office")
    {
        Version = '9.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '31bf3856ad364e35';

        type("Microsoft.Dynamics.Nav.Integration.Office.Excel.ExcelHelper"; "ExcelHelper")
        {
        }
    }

    assembly("GLAccountStg_Service")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.GLAccountStg_Service"; "GLAccountStg_Service")
        {
        }

        type("ConsumeNAVWS.GLAccountStg"; "GLAccountStg")
        {
        }
    }

    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Array"; "Array")
        {
        }

        type("System.DateTime"; "DateTime")
        {
        }

        type("System.Collections.Generic.Dictionary`2"; "Dictionary_Of_T_U")
        {
        }

        type("System.Text.Encoding"; "Encoding")
        {
        }

        type("System.Convert"; "Convert")
        {
        }

        type("System.IO.StreamReader"; "StreamReader")
        {
        }
    }

    assembly("CorpGLAccountStg_Service")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.CorpGLAccountStg_Service"; "CorpGLAccountStg_Service")
        {
        }

        type("ConsumeNAVWS.CorpGLAccountStg"; "CorpGLAccountStg")
        {
        }
    }

    assembly("DataImportManagement")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.DataImportManagement"; "DataImportManagement")
        {
        }
    }

    assembly("ImportLog_Service")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.ImportLog"; "ImportLog")
        {
        }

        type("ConsumeNAVWS.ImportLog_Service"; "ImportLog_Service")
        {
        }
    }

    assembly("ImportErrorLog_Service")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.ImportErrorLog_Service"; "ImportErrorLog_Service")
        {
        }

        type("ConsumeNAVWS.ImportErrorLog"; "ImportErrorLog")
        {
        }

        type("ConsumeNAVWS.ImportErrorLog_Filter"; "ImportErrorLog_Filter")
        {
        }

        type("ConsumeNAVWS.ImportErrorLog_Fields"; "ImportErrorLog_Fields")
        {
        }
    }

    assembly("SystemService")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.SystemService"; "SystemService")
        {
        }
    }

    assembly("GenJnlLineStg_Service")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.GenJnlLineStg"; "GenJnlLineStg")
        {
        }

        type("ConsumeNAVWS.GenJnlLineStg_Service"; "GenJnlLineStg_Service")
        {
        }
    }

    assembly("CustomerStg_Service")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.CustomerStg_Service"; "CustomerStg_Service")
        {
        }

        type("ConsumeNAVWS.CustomerStg"; "CustomerStg")
        {
        }
    }

    assembly("VendorStg_Service")
    {
        Version = '0.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("ConsumeNAVWS.VendorStg_Service"; "VendorStg_Service")
        {
        }

        type("ConsumeNAVWS.VendorStg"; "VendorStg")
        {
        }
    }

    assembly("System.Data")
    {
        Version = '2.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Data.DataTable"; "DataTable")
        {
        }
    }

    assembly("System.Xml")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Xml.XmlConvert"; "XmlConvert")
        {
        }
    }

    assembly("System.Net.Http")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("System.Net.Http.HttpResponseMessage"; "HttpResponseMessage")
        {
        }

        type("System.Net.Http.StringContent"; "StringContent")
        {
        }

        type("System.Net.Http.HttpContent"; "HttpContent")
        {
        }

        type("System.Net.Http.HttpClient"; "HttpClient")
        {
        }

        type("System.Net.Http.Headers.AuthenticationHeaderValue"; "AuthenticationHeaderValue")
        {
        }

        type("System.Net.Http.HttpRequestMessage"; "HttpRequestMessage")
        {
        }

        type("System.Net.Http.HttpMethod"; "HttpMethod")
        {
        }
    }

    assembly("Newtonsoft.Json")
    {
        Version = '6.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = '30ad4fe6b2a6aeed';

        type("Newtonsoft.Json.Linq.JToken"; "JToken")
        {
        }

        type("Newtonsoft.Json.Linq.JArray"; "JArray")
        {
        }

        type("Newtonsoft.Json.Linq.JObject"; "JObject")
        {
        }

        type("Newtonsoft.Json.JsonConvert"; "JsonConvert")
        {
        }

        type("Newtonsoft.Json.Linq.JTokenWriter"; "JTokenWriter")
        {
        }
    }

    assembly("Microsoft.VisualBasic")
    {
        Version = '10.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b03f5f7f11d50a3a';

        type("Microsoft.VisualBasic.Interaction"; "Interaction")
        {
        }
    }

    assembly("System")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Uri"; "Uri")
        {
        }

        type("System.Net.ServicePointManager"; "ServicePointManager")
        {
        }

        type("System.Net.SecurityProtocolType"; "SecurityProtocolType")
        {
        }

        type("System.Text.RegularExpressions.Regex"; "Regex")
        {
        }

        type("System.Text.RegularExpressions.Match"; "Match")
        {
        }
    }

}
*/