using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_demo1_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Session.Add("Flag", 0);
            btnSubmit.Text = "ADD";
        }
    }

    protected void Edit1(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)((Control)sender).Parent.Parent;
        int index = gvRow.RowIndex;
        uid.Value = GridView1.DataKeys[index].Values["BlogID"].ToString();
        txtAuthor.Text = GridView1.Rows[index].Cells[3].Text;
        txtBlogName.Text = GridView1.Rows[index].Cells[2].Text;
        txtContent.Text = GridView1.Rows[index].Cells[4].Text;
        Label1.Text = GridView1.DataKeys[index].Values["ImagePath"].ToString();
        Session["Flag"]=1;
        btnSubmit.Text = "Update";
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string imageName = Label1.Text;

        if (fileUploadImage.HasFile)
        {
            string fname = fileUploadImage.FileName;
            if (fname.EndsWith("jpg") || fname.EndsWith("png") || fname.EndsWith("jpeg"))
            {
                fileUploadImage.SaveAs(Server.MapPath("../img/") + fname);
                imageName = fname;
            }
            else
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Select a valid image";
                return;
            }
        }

        if (Session["Flag"] != null && Convert.ToInt32(Session["Flag"]) == 0)
        {
            if (imageName == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Image is required for insertion";
                return;
            }

            SqlDataSource1.InsertParameters["BlogName"].DefaultValue = txtBlogName.Text;
            SqlDataSource1.InsertParameters["Author"].DefaultValue = txtAuthor.Text;
            string comment = txtContent.Text.Replace("'", "''"); // Escape single quote
            SqlDataSource1.InsertParameters["Content"].DefaultValue = comment;
            SqlDataSource1.InsertParameters["ImagePath"].DefaultValue = imageName;
            SqlDataSource1.InsertParameters["CreatedAt"].DefaultValue = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            SqlDataSource1.Insert();
            clear();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "showalert", "success('Details Inserted');", true);
        }
        else
        {
            SqlDataSource1.UpdateParameters["BlogID"].DefaultValue = uid.Value;
            SqlDataSource1.UpdateParameters["BlogName"].DefaultValue = txtBlogName.Text;
            SqlDataSource1.UpdateParameters["Author"].DefaultValue = txtAuthor.Text;
            string comment = txtContent.Text.Replace("'", "''"); // Escape single quote
            SqlDataSource1.InsertParameters["Content"].DefaultValue = comment;
            SqlDataSource1.UpdateParameters["ImagePath"].DefaultValue = imageName;
            SqlDataSource1.Update();
            clear();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "showalert", "success('Details Updated');", true);
        }
        GridView1.DataBind();
    }
    private void clear()
    {
        txtBlogName.Text = "";
        txtAuthor.Text = "";
        txtContent.Text = "";
        Label1.Text = "";
        uid.Value = ""; 
        Session["Flag"] = 0;
        btnSubmit.Text = "ADD";
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.TableSection = TableRowSection.TableHeader;
        }
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.UseAccessibleHeader = true;
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "del")
        {
            SqlDataSource1.DeleteParameters["BlogId"].DefaultValue = e.CommandArgument.ToString();
            SqlDataSource1.Delete();
            GridView1.DataBind();
        }
        
    }

}
