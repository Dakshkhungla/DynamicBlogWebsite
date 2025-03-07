using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (!string.IsNullOrEmpty(e.CommandArgument.ToString()))
        {
            Session["blogid"] = e.CommandArgument.ToString();
            Response.Redirect("Blog_Details.aspx");
        }
    }


    protected string FormatDate(object date)
    {
        if (date != null && date != DBNull.Value)
        {
            DateTime formattedDate;
            string dateString = Convert.ToString(date);

            if (DateTime.TryParse(dateString, out formattedDate))
            {
                return formattedDate.ToString("dd-MMM-yyyy"); 
            }
        }
        return "N/A";
    }


}