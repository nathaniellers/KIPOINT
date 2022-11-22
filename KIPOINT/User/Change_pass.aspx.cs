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
    public partial class Change_pass : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        void cleartext()
        {
            Label1.Text = "";
            CurrentPass.Text = "";
            NewPass.Text = "";
            ConfirmPass.Text = "";
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (CurrentPass.Text == "" || NewPass.Text == "" || ConfirmPass.Text == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Input the missing details. Kindly complete it before you submit.";
            }
            else
            {
               if (CurrentPass.Text == Session["password"].ToString())
                {
                    if (NewPass.Text == ConfirmPass.Text)
                    {
                        if ( ConfirmPass.Text.Length >= 5 & NewPass.Text.Length >= 5)
                        {
                            con.Open();

                            MySqlCommand cmd = new MySqlCommand("UPDATE user SET password = @password WHERE id = @id", con);

                            cmd.Parameters.AddWithValue("@id", Session["id"]);
                            cmd.Parameters.AddWithValue("@password", ConfirmPass.Text);
                            cmd.ExecuteNonQuery();
                          
                            Session["password"] = ConfirmPass.Text.ToString();
                            cleartext();
                            Label1.ForeColor = System.Drawing.Color.Green;
                            Label1.Text = "Successfully updated!";
                        }
                        else
                        {
                            Label1.ForeColor = System.Drawing.Color.Red;
                            Label1.Text = "You need to write at least 5 characters";
                        }
                    }
                    else
                    {
                        Label1.ForeColor = System.Drawing.Color.Red;
                        Label1.Text = "Your new Password didn't match on confirmation password. Kindly type it correctly.";
                    }
                }
                else
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Current password in incorrect. Kindly type your current password.";
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (Session["user_type"].ToString() == "Residential")
            {
                Response.Redirect("~/User/Residential/Index.aspx");
            }
            else
            {
                cleartext();
                Response.Redirect("~/Default.aspx");
            }

        }
    }
}