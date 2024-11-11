using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using Newtonsoft.Json;
using System.Collections.Generic;

public partial class Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            return;
        }

        string url = RTUrlBuilder.BuildURL("newest", 1);

        string responseBody = BasicHTTPGetRequest.Send(url);

        dynamic jsonObject = JsonConvert.DeserializeObject(responseBody);

        List<CardData> cardList = new List<CardData>();

        foreach (var movie in jsonObject.grid.list)
        {
            cardList.Add(new CardData()
            {
                Title = movie.title,
                ReleaseDate = movie.releaseDateText,
                CriticsScore = movie.criticsScore.scorePercent == "" ? "-" : movie.criticsScore.scorePercent,
                ImageUrl = movie.posterUri,
                Type = movie.type
            });
        }

        Repeater1.DataSource = cardList;

        Repeater1.DataBind();
    }
}
