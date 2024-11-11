/// <summary>
/// Summary description for RTUrlBuilder
/// </summary>
public static class RTUrlBuilder
{
    const string URLBase = "https://www.rottentomatoes.com/napi/browse/movies_in_theaters/sort:";
    public static string BuildURL(string sortBy, int pageNumber)
    {
        return string.Format("{0}{1}?page={2}", URLBase, sortBy, pageNumber); ;
    }
}