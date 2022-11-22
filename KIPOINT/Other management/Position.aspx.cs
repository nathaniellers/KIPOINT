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

namespace KIPOINT.Other_management
{
    public partial class Position : System.Web.UI.Page
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
                load_data_position();
            }
        }

        void cleartext()
        {
            txt_limit.Text = "";
            txt_position_name.Text = "";
            txt_rank.Text = "";
        }

        void load_data_position()
        {
            MySqlCommand cmd = new MySqlCommand("SELECT *  FROM position ORDER BY prank asc", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);

                position_view.DataSource = dt;
                position_view.DataBind();
            }
        }

        protected void OnRowDeleting2(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(position_view.DataKeys[e.RowIndex].Values[0]);

            MySqlCommand cmd = new MySqlCommand("delete FROM position where id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            load_data_position();
        }

        protected void OnRowUpdating2(object sender, GridViewUpdateEventArgs e)
        {


            GridViewRow row = position_view.Rows[e.RowIndex];
            int id = Convert.ToInt32(position_view.DataKeys[e.RowIndex].Values[0]);

            string position_name = (row.FindControl("txt_position_name") as TextBox).Text;
            string limit = (row.FindControl("txt_limit") as TextBox).Text;
            string rank = (row.FindControl("txt_rank") as TextBox).Text;




            if (position_name == "" || limit == "" | rank == "")
            {
                Label2.ForeColor = System.Drawing.Color.Red;
                Label2.Text = "Missing input. Kindly fill up religion name.";
            }
            else
            {
                if (CheckDataSubmit("position", "pname", position_name, id) == true)
                {
                    Label2.ForeColor = System.Drawing.Color.Red;
                    Label2.Text = "Position name is already exist in the system";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("UPDATE position SET pname=@pname, plimit=@plimit , prank=@prank WHERE id = @id", con);

                    cmd.Parameters.AddWithValue("@pname", position_name);
                    cmd.Parameters.AddWithValue("@plimit", limit);
                    cmd.Parameters.AddWithValue("@prank", rank);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                    load_data_position();
                    cleartext();
                    position_view.EditIndex = -1;
                    this.load_data_position();
                }
            }
        }



        protected void OnRowEditing2(object sender, GridViewEditEventArgs e)
        {
            position_view.EditIndex = e.NewEditIndex;
            this.load_data_position();
        }

        protected void OnRowCancelingEdit2(object sender, EventArgs e)
        {
            position_view.EditIndex = -1;
            this.load_data_position();
        }

        protected void OnRowDataBound2(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != position_view.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (txt_position_name.Text == "" || txt_limit.Text == "" | txt_rank.Text == "")
            {
                Label2.ForeColor = System.Drawing.Color.Red;
                Label2.Text = "Missing input. Kindly fill up position name.";
            }
            else
            {
                if (CheckDataSubmit("position", "pname", txt_position_name.Text, 0) == true)
                {
                    Label2.ForeColor = System.Drawing.Color.Red;
                    Label2.Text = "Position name is already exist in the system";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("INSERT INTO position (pname, plimit, prank) VALUES (@pname, @plimit, @prank) ", con);

                    cmd.Parameters.AddWithValue("@pname", txt_position_name.Text);
                    cmd.Parameters.AddWithValue("@plimit", txt_limit.Text);
                    cmd.Parameters.AddWithValue("@prank", txt_rank.Text);
                    cmd.ExecuteNonQuery();

                    load_data_position();
                    cleartext();

                    Label2.ForeColor = System.Drawing.Color.Green;
                    Label2.Text = "Successfully added";
                }
            }
        }

        public Boolean CheckDataSubmit(string table, string colname, string data, int id)
        {
            string qry = "SELECT  * from " + table + " where " + colname + "=@data and id!=@id";
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

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            cleartext();
        }
    }
}