using System;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;

public class Dao
{
    public int pnum = 0;
    private SqlConnection con;

    public Dao()
    {
        con = new SqlConnection("Data Source=lenovo-nwsl\\sqlexpress;Initial Catalog=blog;Integrated Security=True");
    }

    public DataSet GetData(string qry)
    {
        try
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(qry, con);
            con.Open();
            da.SelectCommand.ExecuteReader();
            con.Close();
            da.Fill(ds);
            return ds;
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            return null;
        }
    }

    public void ModifyData(string str)
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(str, con);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }

    public void SendMail(string sendEmail, string msg)
    {
        string from = "passreset481@gmail.com";
        string pass = "rrcoxxrxdkguckps";

        MailMessage message = new MailMessage
        {
            From = new MailAddress(from),
            Subject = "Code for resetting password",
            Body = msg
        };

        message.To.Add(new MailAddress(sendEmail));

        SmtpClient smtp = new SmtpClient
        {
            Host = "smtp.gmail.com",
            EnableSsl = true,
            Port = 587,
            Credentials = new System.Net.NetworkCredential(from, pass)
        };

        smtp.Send(message);
    }
}
