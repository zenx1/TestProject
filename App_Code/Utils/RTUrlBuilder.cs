using System;

using Telerik.Web.Spreadsheet;

/// <summary>
/// Summary description for RTUrlBuilder
/// </summary>
public static class RTUrlBuilder
{
    const string URLBase = "https://www.rottentomatoes.com/napi/browse/movies_in_theaters/sort:";
    public static string BuildURL(string sortBy, string endCursor = null)
    {
        if (endCursor == null)
        {
            return BuildURL(sortBy);
        }
        return string.Format("{0}?after={1}", BuildURL(sortBy), endCursor);
    }
    public static string BuildURL(string sortBy)
    {
        return string.Format("{0}{1}", URLBase, sortBy);
    }
}