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
    public partial class Term : System.Web.UI.Page
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
     

            string qry = "SELECT id ,DATE_FORMAT(term_start,'%Y-%m-%d') as term_start,DATE_FORMAT(term_end,'%Y-%m-%d') as term_end FROM year_term";
            MySqlCommand cmd = new MySqlCommand(qry, con);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                txt_TermStart.Text = dt.Rows[0]["term_start"].ToString();
                txt_TermEnd.Text = dt.Rows[0]["term_end"].ToString();
            }

         }





        protected void btn_add_Click(object sender, EventArgs e)
        {
            DateTime start = DateTime.Parse(txt_TermStart.Text);
            DateTime end = DateTime.Parse(txt_TermEnd.Text);

            if (start == end)
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Term date should not be the same";
            }
            else
            {
                if (start > end)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Term start date should be greater then to end date";
                }
                else
                {
                    MySqlCommand cmd_edit = new MySqlCommand("UPDATE year_term SET term_start=@term_start, term_end=@term_end WHERE id = @id", con);

                    cmd_edit.Parameters.AddWithValue("@term_start", txt_TermStart.Text);
                    cmd_edit.Parameters.AddWithValue("@term_end", txt_TermEnd.Text);
                    cmd_edit.Parameters.AddWithValue("@id", 1);
                    cmd_edit.ExecuteNonQuery();
                    load_data();
                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Text = "Successfully updated!";
                }
            }
           
        }

        


    }
}