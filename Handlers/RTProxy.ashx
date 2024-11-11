<%@ WebHandler Language="C#" Class="RTProxy" %>

using System;
using System.Web;
using System.Net;
using System.IO;

public class RTProxy : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (String.IsNullOrEmpty(context.Request.QueryString["sort"]))
        {
            context.Response.End();
        }

        string url = RTUrlBuilder.BuildURL(context.Request.QueryString["sort"], 1);

        string responseBody = BasicHTTPGetRequest.Send(url);

        context.Response.ContentType = "text/json";

        context.Response.Write(responseBody);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}