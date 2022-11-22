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
    public partial class Forget_pass : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void cleartext()
        {
            username.Text = "";
            secret_ans.Text = "";
            new_pass.Text = "";
            confirm_pass.Text = "";
        }

       
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Submit")
            {
                if (username.Text == "")
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Missing username. Please input your username.";
                }
                else
                { //search the user details via username

                    string qry = "select * from user where username=@username";
                    MySqlCommand cmd = new MySqlCommand(qry, con);
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@username", username.Text);
                    

                    // MySqlDataReader sdr = cmd.ExecuteReader();
                    MySqlDataAdapter d = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    d.Fill(dt);

                    if (dt.Rows.Count >= 1)
                    {
                        Session["id"] = dt.Rows[0]["id"].ToString();
                        Session["firstname"] = dt.Rows[0]["firstname"].ToString();
                        Session["lastname"] = dt.Rows[0]["lastname"].ToString();
                        Session["username"] = dt.Rows[0]["username"].ToString();
                        Session["password"] = dt.Rows[0]["password"].ToString();
                        Session["secret_question"] = dt.Rows[0]["secret_question"].ToString();
                        Session["secret_answer"] = dt.Rows[0]["secret_answer"].ToString();
                        Session["user_type"] = dt.Rows[0]["user_type"].ToString();
                        Session["is_deleted"] = dt.Rows[0]["is_deleted"].ToString();
                        Session["is_active"] = dt.Rows[0]["is_active"].ToString();

                        
                        //string is_deleted = Session["is_deleted"].ToString();

                        if (Session["is_deleted"].ToString() == "True")
                        {
                            Label1.ForeColor = System.Drawing.Color.Red;
                            Label1.Text = "Your account has been suspended. Kindly check with administrator.";
                        }
                        else
                        {
                            if (Session["is_active"].ToString() == "True")
                            {       //login
                                username.ReadOnly = true;
                                secret_question.Visible = true;
                                secret_ans.ReadOnly = false;
                                Button1.Text = "Next";
                                Button2.Text = "Previous";
                                Label1.Text = "";
                                secret_question.Text = Session["secret_question"].ToString();


                            }
                            else
                            {       //newuser
                                Label1.ForeColor = System.Drawing.Color.Gold;
                                Label1.Text = "Username input is a new user. Kindly login to finish the setup of this account.";
                            }
                        }
                    }
                    else
                    {
                        Label1.ForeColor = System.Drawing.Color.Red;
                        Label1.Text = "Username input is not existing in the system. Please try again.";
                    }


                }
            }
            else if (Button1.Text == "Next")
            {
                if (secret_ans.Text == "")
                {
                    Label2.ForeColor = System.Drawing.Color.Red;
                    Label2.Text = "Missing secret answer. Please input your secret answer.";
                }
                else
                {    
                    
                    if (secret_ans.Text == Session["secret_answer"].ToString())
                    {
                        secret_question.Visible = false;
                        secret_ans.ReadOnly = true;
                        new_pass.ReadOnly = false;
                        confirm_pass.ReadOnly = false;
                        Button1.Text = "Update";
                        Label2.Text = "";
                    }
                    else
                    {
                        Label2.ForeColor = System.Drawing.Color.Red;
                        Label2.Text = "Incorrect secret answer. Please try again.";
                    }

                }
            }
            else 
            {
                if (new_pass.Text == "" || confirm_pass.Text == "")
                {
                    Label3.ForeColor = System.Drawing.Color.Red;
                    Label3.Text = "Missing password. Please input your new and confirmation password.";
                }
                else
                {
                    if (new_pass.Text == confirm_pass.Text)
                    {
                        if (new_pass.Text.Length >= 5 & confirm_pass.Text.Length >= 5)
                        {
                            if (Session["password"].ToString() == new_pass.Text)
                            {

                                Label3.ForeColor = System.Drawing.Color.Red;
                                Label3.Text = "Kindly type new password on your account.";

                            }
                            else
                            {
                                //update the password 
                                con.Open();

                                MySqlCommand cmd = new MySqlCommand("UPDATE user SET password = @password WHERE id = @id", con);

                                cmd.Parameters.AddWithValue("@id", Session["id"]);
                                cmd.Parameters.AddWithValue("@password", confirm_pass.Text);
                                cmd.ExecuteNonQuery();

                                Label3.ForeColor = System.Drawing.Color.Green;
                                Label3.Text = "Your account has been retrieve succesfully. Kindly re-login your account. ";
                                cleartext();
                                Button1.Visible = false;
                                Button2.Text = "Close";
                            }


                        }
                        else 
                        {
                            Label3.ForeColor = System.Drawing.Color.Red;
                            Label3.Text = "You need to write at least 5 characters";
                        }
                    }
                    else 
                    {
                        Label3.ForeColor = System.Drawing.Color.Red;
                        Label3.Text = "Your new Password didn't match on confirmation password. Kindly type it correctly.";
                    }    
                }
            }

        }





        protected void Button2_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Next" & Button2.Text == "Previous")
            { 
                username.ReadOnly = false;
                secret_question.Visible = false;
                secret_ans.ReadOnly = true;
                Label1.Text = "";
                Label2.Text = "";
                Button1.Text = "Submit";
                Button2.Text = "Close";

            }
            else if (Button1.Text == "Update" & Button2.Text == "Previous")
            { 
                secret_question.Visible = true;
                secret_ans.ReadOnly = false;
                new_pass.ReadOnly = true;
                confirm_pass.ReadOnly = true;
                Label3.Text = "";
                Button1.Text = "Next";
            }
            else 
            {
                cleartext();
                Response.Redirect("/Login.aspx");
            }
        }

    }
}