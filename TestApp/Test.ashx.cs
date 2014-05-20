using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestApp
{
    /// <summary>
    /// Summary description for Test
    /// </summary>
    public class Test : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request.Url.Segments.Last().Trim('/');
            switch(method)
            {
                case "HelloWorld":
                    HelloWorld(context);
                    break;
                case "MiscData":
                    MiscData(context);
                    break;
                default:
                    Error(context);
                    break;
            }
            
        }

        private static void MiscData(HttpContext context)
        {
            string jsonData;
            string[] dataToProvide = new string[3] { "TestOne", "TestTwo", "TestThree" };
            jsonData = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(dataToProvide);
            context.Response.StatusCode = 200;
            context.Response.ContentType = "application/json";
            context.Response.Write(jsonData);
        }

        private static void Error(HttpContext context)
        {
            context.Response.StatusCode = 400;
            context.Response.ContentType = "text/plain";
            context.Response.Write("Unsupported Method.");
        }

        private static void HelloWorld(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
        }



        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}