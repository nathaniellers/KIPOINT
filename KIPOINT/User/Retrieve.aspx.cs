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

namespace KIPOINT.Users
{
    public partial class Retrieve : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Close();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            if (!this.IsPostBack)
            {
                load_data();
                
            }
        }

        void load_data()
        {
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM view_user where is_deleted = 1 ", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                userList.DataSource = dt;
                userList.DataBind();
            }
        }
        protected void OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "btn_Retrieve") return;
            int id = Convert.ToInt32(e.CommandArgument);

            MySqlCommand cmd = new MySqlCommand("UPDATE user SET is_deleted=0 WHERE id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();          
            load_data();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(userList.DataKeys[e.RowIndex].Values[0]);

            MySqlCommand cmd = new MySqlCommand("Delete from user WHERE id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();          
            load_data();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {             
                foreach (Button button in e.Row.Cells[6].Controls.OfType<Button>())
                {
                    if (button.CommandName == "Delete")
                    {
                        button.Attributes["onclick"] = "if(!confirm('Do you want to delete?')){ return false; };";
                    }
                }
            }
        }

    }
}