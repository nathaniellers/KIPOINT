using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.Types;
using MySql.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace KIPOINT.Other_management
{
    public partial class Venue : System.Web.UI.Page
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

                load_data_venue();
            }
        }

        void load_data_venue()
        {
            MySqlCommand cmd = new MySqlCommand("SELECT *  FROM venue", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);

                venue_view.DataSource = dt;
                venue_view.DataBind();
            }
        }


        protected void OnRowDeleting_venue(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(venue_view.DataKeys[e.RowIndex].Values[0]);

            MySqlCommand cmd = new MySqlCommand("delete FROM venue where id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            load_data_venue();
        }
        protected void OnRowUpdating_venue(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = venue_view.Rows[e.RowIndex];
            int id = Convert.ToInt32(venue_view.DataKeys[e.RowIndex].Values[0]);
            string venue = (row.FindControl("txt_venue") as TextBox).Text;
            int capacity = int.Parse((row.FindControl("txt_capacity") as TextBox).Text);


            if (venue == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing input. Kindly fill up venue name.";
            }
            else
            {
                if (CheckDataSubmit("venue", "venue", venue, id) == true)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "venue is already exist in the system";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("UPDATE venue SET venue = @venue , capacity=@capacity WHERE id = @id", con);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@venue", venue);
                    cmd.Parameters.AddWithValue("@capacity", capacity);
                    cmd.ExecuteNonQuery();
                    load_data_venue();
                    cleartext();

                    venue_view.EditIndex = -1;
                    this.load_data_venue();
                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Text = "Successfully updated";
                }
            }

        }

        protected void OnRowEditing_venue(object sender, GridViewEditEventArgs e)
        {
            venue_view.EditIndex = e.NewEditIndex;
            this.load_data_venue();
        }

        protected void OnRowCancelingEdit_venue(object sender, EventArgs e)
        {
            venue_view.EditIndex = -1;
            this.load_data_venue();
        }

        protected void OnRowDataBound_venue(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != venue_view.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
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
        void cleartext()
        {
            txt_venue.Text = "";
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (txt_venue.Text == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing input. Kindly fill up venue name.";
            }
            else
            {
                if (CheckDataSubmit("venue", "venue", txt_venue.Text, 0) == true)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "venue is already exist in the system";
                }
                else
                {
                    MySqlCommand cmd = new MySqlCommand("INSERT INTO venue (venue,capacity) VALUES (@venue,@capacity) ", con);

                    cmd.Parameters.AddWithValue("@venue", txt_venue.Text);
                    cmd.Parameters.AddWithValue("@capacity", txt_capacity.Text);
                    cmd.ExecuteNonQuery();
                    load_data_venue();
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