using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using MySql.Data.Types;
using MySql.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace KIPOINT
{
    public partial class New_user : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = Session["firstname"].ToString();
            Label2.Text = Session["lastname"].ToString();
            Label3.Text = Session["username"].ToString();
        }
        
        void cleartext()
        {
            secret_ans.Text = "";
            new_pass.Text = "";
            confirm_pass.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (secret_ans.Text == "")
            {
                Label4.ForeColor = System.Drawing.Color.Red;
                Label4.Text = "Kindly input your secret answer";
            }
            else
            {
                new_pass.Visible = true;
                confirm_pass.Visible = true;
                Button3.Visible = true;
                secret_ans.Visible = false;
                Button2.Text = "Previous";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
 
            if (Button2.Text == "Cancel")
            { 
                cleartext();
                Response.Redirect("/Login.aspx");
            }

            if (Button2.Text == "Previous")
            {
                Button2.Text = "Cancel";
                new_pass.Text = "";
                confirm_pass.Text = "";
                new_pass.Visible = false;
                confirm_pass.Visible = false;
                secret_ans.Visible = true;
                Button3.Visible = false;
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
           if (Button3.Text == "Submit")
            {

                if (new_pass.Text == "" || confirm_pass.Text == "")
                {
                    Label5.ForeColor = System.Drawing.Color.Red;
                    Label5.Text = "Missing password. Kindly complete it!";
                }
                else
                {
                    if (new_pass.Text == confirm_pass.Text)
                    {
                        if (confirm_pass.Text.Length >= 5)
                        {
                            con.Open();

                            MySqlCommand cmd = new MySqlCommand("UPDATE user SET secret_question = @secret_question, secret_answer = @secret_answer, password = @password, is_active=@is_active WHERE id = @id", con);

                            cmd.Parameters.AddWithValue("@id", Session["id"]);
                            cmd.Parameters.AddWithValue("@secret_question", secret_question.SelectedValue);
                            cmd.Parameters.AddWithValue("@secret_answer", secret_ans.Text);
                            cmd.Parameters.AddWithValue("@password", confirm_pass.Text);
                            cmd.Parameters.AddWithValue("@is_active", 1);


                            cmd.ExecuteNonQuery();
                            con.Close();

                            Label5.ForeColor = System.Drawing.Color.Green;
                            Label5.Text = "Your account has been successfully set up. Please try to re-login your account!";
                            Button3.Text = "Close";
                            

                        }
                        else
                        {
                            Label5.ForeColor = System.Drawing.Color.Red;
                            Label5.Text = "You need to write at least 5 characters.";
                        }
                    }
                    else
                    {
                        Label5.ForeColor = System.Drawing.Color.Red;
                        Label5.Text = "Your new password and confirmation didn't matched.";
                    }
                }
            }
            else
            {
                cleartext();
                Response.Redirect("/Login.aspx");
            }
        }
    }
}