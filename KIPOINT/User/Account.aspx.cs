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

namespace KIPOINT.User
{ 
    public partial class Account : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {

            con.Close();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }


            if (!IsPostBack)
            {
                loadSessions();
            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (txt_fname.Text == "" || txt_lname.Text == "" || txt_username.Text == "" || txt_mi.Text == "")
            {
                //Response.Write("<script>alert('Please complete the input before submitting it.');</script>");
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Please complete the input before submitting it.";
            
            }
            else
            {
                    

                    MySqlCommand cmd = new MySqlCommand("UPDATE user SET firstname = @firstname, lastname = @lastname, mi=@mi, username = @username WHERE id = @id", con);

                    cmd.Parameters.AddWithValue("@id", Session["id"].ToString());
                    cmd.Parameters.AddWithValue("@firstname", txt_fname.Text);
                    cmd.Parameters.AddWithValue("@lastname", txt_lname.Text);
                    cmd.Parameters.AddWithValue("@mi", txt_mi.Text);
                    cmd.Parameters.AddWithValue("@username", txt_username.Text);
                    cmd.ExecuteNonQuery();
                    //loadSessions();
                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Text = "Successfully updated!";
            } 
        }

        public void loadSessions()
        {
            txt_fname.Text = Session["firstname"].ToString();
            txt_lname.Text = Session["lastname"].ToString();
            txt_username.Text = Session["username"].ToString();
            txt_mi.Text = Session["middlename"].ToString();
        }

        void cleartext ()
        {
            txt_fname.Text = "";
            txt_lname.Text = "";
            txt_username.Text = "";
            txt_mi.Text = "";
            Label1.Text = "";
        }

        protected void Button2_Click1(object sender, EventArgs e)
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

