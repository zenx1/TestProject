<%@ WebHandler Language="C#" Class="RTProxy" %>

using System;
using System.Web;
using System.Net;
using System.IO;

public class RTProxy : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string sort = context.Request.QueryString["sort"];

        if (String.IsNullOrEmpty(sort))
        {
            context.Response.End();
        }

        string endCursor = context.Request.QueryString["endCursor"];

        string url = String.IsNullOrEmpty(endCursor) ? RTUrlBuilder.BuildURL(sort) : RTUrlBuilder.BuildURL(sort, endCursor);

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