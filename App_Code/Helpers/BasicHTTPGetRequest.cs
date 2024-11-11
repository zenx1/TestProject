using System;
using System.IO;
using System.Net;

/// <summary>
/// Summary description for BasicHTTPGetRequest
/// </summary>
public static class BasicHTTPGetRequest
{
    public static string Send(string url)
    {
        try
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);

            request.Method = "GET";

            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            {
                string responseBody;

                using (var reader = new StreamReader(response.GetResponseStream()))
                {
                    responseBody = reader.ReadToEnd();
                }

                response.Close();

                return responseBody;
            }
        }
        catch (Exception ex)
        {
            return null;
        }
    }
}