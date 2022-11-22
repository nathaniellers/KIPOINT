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
    public partial class Others : System.Web.UI.Page
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
                load_data_religion();

            }
        }

        void cleartext()
        {

            txt_religion.Text = "";

        }

        void load_data_religion()
        {

            MySqlCommand cmd = new MySqlCommand("SELECT * FROM religion", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);


            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                religion_view.DataSource = dt;
                religion_view.DataBind();
            }
        }



        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(religion_view.DataKeys[e.RowIndex].Values[0]);


            MySqlCommand cmd = new MySqlCommand("delete FROM religion where id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();

            load_data_religion();

        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {


            GridViewRow row = religion_view.Rows[e.RowIndex];
            int id = Convert.ToInt32(religion_view.DataKeys[e.RowIndex].Values[0]);
            string religion_name = (row.FindControl("txt_religion") as TextBox).Text;

            if (religion_name == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing input. Kindly fill up religion name.";
            }
            else
            {
                if (CheckDataSubmit("religion", "religion_name", religion_name, id) == true)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Religion name is already exist in the system";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("UPDATE religion SET religion_name = @religion_name WHERE id = @id", con);

                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@religion_name", religion_name);
                    cmd.ExecuteNonQuery();
                    load_data_religion();
                    cleartext();
                    religion_view.EditIndex = -1;
                    this.load_data_religion();
                }
            }
        }
        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            religion_view.EditIndex = e.NewEditIndex;
            this.load_data_religion();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            religion_view.EditIndex = -1;
            this.load_data_religion();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != religion_view.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }

        }


        public Boolean CheckDataSubmit(string table,string colname,string data, int id)
        {
            string qry = "SELECT  * from "+table+" where "+colname+"=@data and id!=@id";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@data", data);
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

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (txt_religion.Text == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing input. Kindly fill up religion name.";
            }
            else
            {
                if (CheckDataSubmit("religion", "religion_name", txt_religion.Text, 0) == true)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Religion name is already exist in the system";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("Insert INTO religion (religion_name) VALUES (@religion_name) ", con);

                    cmd.Parameters.AddWithValue("@religion_name", txt_religion.Text);
                    cmd.ExecuteNonQuery();
                    load_data_religion();
                    cleartext();

                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Text = "Successfully added";
                    Response.Redirect(Request.Url.AbsoluteUri);
                }
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            cleartext();
        }
    }
}