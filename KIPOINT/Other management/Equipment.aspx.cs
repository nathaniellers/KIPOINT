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

namespace KIPOINT
{
    public partial class Equipment : System.Web.UI.Page
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

        void cleartext()
        {
            txt_equipment.Text = "";
            txt_eq_num.Text = "";
        }

        void load_data()
        {
            MySqlCommand cmd = new MySqlCommand("SELECT *  FROM equipment", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);

                equipment_view.DataSource = dt;
                equipment_view.DataBind();
            }
        }

        protected void OnRowDeleting_venue(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(equipment_view.DataKeys[e.RowIndex].Values[0]);

            MySqlCommand cmd = new MySqlCommand("delete FROM equipment where id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            load_data();
        }

        protected void OnRowUpdating_venue(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = equipment_view.Rows[e.RowIndex];
            int id = Convert.ToInt32(equipment_view.DataKeys[e.RowIndex].Values[0]);
            string equipment = (row.FindControl("txt_equipment") as TextBox).Text;
            string eq_num = (row.FindControl("txt_eq_num") as TextBox).Text;
            string eq_brand = (row.FindControl("txt_brand") as TextBox).Text;

            MySqlCommand cmd = new MySqlCommand("UPDATE equipment SET eq_name=@eq_name ,eq_num=@eq_num, eq_brand=@eq_brand  WHERE id = @id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@eq_name", equipment);
            cmd.Parameters.AddWithValue("@eq_num", eq_num);
            cmd.Parameters.AddWithValue("@eq_brand", eq_brand);
            cmd.ExecuteNonQuery();
            load_data();
            cleartext();
            equipment_view.EditIndex = -1;
            this.load_data();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully updated";
      
        }


        protected void OnRowEditing_venue(object sender, GridViewEditEventArgs e)
        {
            equipment_view.EditIndex = e.NewEditIndex;
            this.load_data();
        }

        protected void OnRowCancelingEdit_venue(object sender, EventArgs e)
        {
            equipment_view.EditIndex = -1;
            this.load_data();
        }

        protected void OnRowDataBound_venue(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != equipment_view.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (txt_equipment.Text == "" || txt_eq_num.Text == "" || txt_brand.Text == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing input or submitting zero count. Kindly complete the fill up.";
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("INSERT INTO equipment (eq_name,eq_num,eq_brand) VALUES (@eq_name,@eq_num,@eq_brand) ", con);

                cmd.Parameters.AddWithValue("@eq_name", txt_equipment.Text);
                cmd.Parameters.AddWithValue("@eq_num", txt_eq_num.Text);
                cmd.Parameters.AddWithValue("@eq_brand", txt_brand.Text);
                cmd.ExecuteNonQuery();
                load_data();
                cleartext();

                Label1.ForeColor = System.Drawing.Color.Green;
                Label1.Text = "Successfully added";
                Response.Redirect(Request.Url.AbsoluteUri);
            }

        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            cleartext();
        }
    }
}