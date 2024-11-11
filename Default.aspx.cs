using System;
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
    }
}
