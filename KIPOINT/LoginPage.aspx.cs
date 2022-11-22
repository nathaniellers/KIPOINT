using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using MySql.Data.MySqlClient;
using MySql.Data.Types;
using MySql.Data;
using System;
using System.Data;

namespace KIPOINT
{
    public partial class LoginPage : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Close();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

        }

        protected void btn_Login_Click1(object sender, EventArgs e)
        {
            try
            {
                if (txtUsername.Text != "" && txtPassword.Text != "")
                {
                    LoginUser(txtUsername.Text, txtPassword.Text);
                }
                else
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Username & Password is missing.";
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }


        void LoginUser(string username, string password)
        {

            bool is_deleted = false;
            bool is_active = false;


            string qry = "select * from user where username=@username and password=@password";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@password", password);

            // MySqlDataReader sdr = cmd.ExecuteReader();
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                Session["id"] = dt.Rows[0]["id"].ToString();
                Session["firstname"] = dt.Rows[0]["firstname"].ToString();
                Session["middlename"] = dt.Rows[0]["mi"].ToString();
                Session["lastname"] = dt.Rows[0]["lastname"].ToString();
                Session["username"] = dt.Rows[0]["username"].ToString();
                Session["password"] = dt.Rows[0]["password"].ToString();
                Session["secret_question"] = dt.Rows[0]["secret_question"].ToString();
                Session["secret_answer"] = dt.Rows[0]["secret_answer"].ToString();
                Session["user_type"] = dt.Rows[0]["user_type"].ToString();
                Session["is_deleted"] = dt.Rows[0]["is_deleted"].ToString();
                Session["is_active"] = dt.Rows[0]["is_active"].ToString();
                Session["Resi_id"] = dt.Rows[0]["Resi_id"].ToString();

                is_active = Boolean.Parse(Session["is_active"].ToString());
                is_deleted = Boolean.Parse(Session["is_deleted"].ToString());


                if (is_deleted)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Your account has been suspended. Kindly check with administrator.";
                }
                else
                {
                    if (is_active)
                    {
                        if (Session["user_type"].ToString() == "Residential")
                        {
                            
                            Response.Redirect("User/Residential/Index.aspx");
                            clear();
                        }
                        else
                        {
                            
                            Response.Redirect("Default.aspx");
                            clear();
                        }
                    }
                    else
                    {
                        //newuser

                        Response.Redirect("User/New_user.aspx");
                        clear();
                    }
                }
            }
            else
            {
                clear();

                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Username & Password is incorrect!";
            }
        }

        void clear()
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
        }


    }
}