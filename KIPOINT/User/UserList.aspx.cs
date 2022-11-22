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
    public partial class UserList : Page
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
                load_data();
            }

           
        }

        void load_data()
        {
            
            MySqlCommand cmd = new MySqlCommand("SELECT * from view_user where is_deleted = 0 and id !=@id", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@id", Session["id"]);


            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                userList.DataSource = dt;
                userList.DataBind();
            }
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {


            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != userList.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
            
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
           

           
             int id = Convert.ToInt32(userList.DataKeys[e.RowIndex].Values[0]);
           
            if (id == 1)
            {
                Response.Write("<script>alert('Cannot be deleted this default account.');</script>");
               
            }  
                else
                {
                   
                    
                    MySqlCommand cmd = new MySqlCommand("UPDATE user SET is_deleted=1 WHERE id=@id", con);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                  
                    load_data();

                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Selected user will moved in archive folder. You can retrieve it via retrieve management.";

                }
        }



        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
           

            GridViewRow row = userList.Rows[e.RowIndex];
            int id = Convert.ToInt32(userList.DataKeys[e.RowIndex].Values[0]);

            string fname = (row.FindControl("txt_fname") as TextBox).Text;
            string lname = (row.FindControl("txt_lname") as TextBox).Text;
            string mname = (row.FindControl("txt_mname") as TextBox).Text;
            string uname = (row.FindControl("txt_username") as TextBox).Text;
            DropDownList user_type = userList.Rows[e.RowIndex].FindControl("ddl_usertype") as DropDownList;

            if (fname == "" || lname == ""|| mname == "" || uname == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Please complete all details before submitting it.";
            }
            else
            {
                if (CheckDataSubmit(uname, id) == true)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Username details is already exist in the system.";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("UPDATE user SET firstname = @firstname, lastname = @lastname, mi = @mi, username = @username , user_type=@user_type WHERE id = @id", con);

                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@firstname", fname);
                    cmd.Parameters.AddWithValue("@lastname", lname);
                    cmd.Parameters.AddWithValue("@mi", mname);
                    cmd.Parameters.AddWithValue("@username", uname);
                    cmd.Parameters.AddWithValue("@user_type", user_type.SelectedItem.Text);

                    cmd.ExecuteNonQuery();
                                 
                    userList.EditIndex = -1;
                    load_data();
                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Text = "Successfully updated.";
                }
            }


        }
        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            userList.EditIndex = e.NewEditIndex;
            load_data();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {  
            userList.EditIndex = -1;
            load_data();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            if (TextBox1.Text == "" || TextBox2.Text == "" || TextBox3.Text == "" || TextBox4.Text == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Please complete all details before submitting it.";
            }
            else
            {
                if (CheckDataSubmit(TextBox3.Text,0) == true)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Username details is already exist in the system.";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("Insert INTO user (firstname,lastname,mi,username,user_type,password) VALUES (@firstname,@lastname,@mi,@username,@user_type,@password) ", con);

                    cmd.Parameters.AddWithValue("@firstname", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@lastname", TextBox2.Text);
                    cmd.Parameters.AddWithValue("@mi", TextBox4.Text);
                    cmd.Parameters.AddWithValue("@username", TextBox3.Text);
                    cmd.Parameters.AddWithValue("@password", TextBox2.Text + '@' + DateTime.Now.ToString("yyyyMMdd"));
                    cmd.Parameters.AddWithValue("@user_type", DropDownList1.SelectedItem.Text);
                    cmd.ExecuteNonQuery();

                    load_data();
                    cleartext();
                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Text = "Successfully added.";
                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
        }


        public Boolean CheckDataSubmit(string uname, int id)
        {
            //to check if there's any same entry in db
            string qry = "SELECT  * from user where username=@username and id!=@id";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@username", uname);
            cmd.Parameters.AddWithValue("@id", id);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                return true;
            }
            return false;             
        }


        protected void Button2_Click(object sender, EventArgs e)
        {
            cleartext();
        }

        void cleartext()
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox3.Text = "";
            TextBox4.Text = "";
        }

     
    }
}