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
using System.IO;


namespace KIPOINT
{

    public partial class Barangay_information : System.Web.UI.Page
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
                refreshdata_Barangay();
            }
        }

        public void refreshdata_Barangay()
        {
            string qry = "select * from barangay_info where id=1";
            MySqlCommand cmd = new MySqlCommand(qry, con);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1) {
                txt_bname.Text = dt.Rows[0]["b_name"].ToString();
                txt_city.Text = dt.Rows[0]["city"].ToString();
                txt_district.Text = dt.Rows[0]["district"].ToString();                            
                logo.ImageUrl =  dt.Rows[0]["b_logo"].ToString();
                Session["LogoPath"] = dt.Rows[0]["b_logo"].ToString();
           }
        }



        protected void btn_update_Click(object sender, EventArgs e)
        {
                     
            if (txt_bname.Text == "" || txt_city.Text == "" || txt_district.Text == "" )
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing details. Kindly complete it before submitting.";
            }
            else
            {                          
                if (Fileupload.HasFile)
                {
                    string filename = Path.GetFileName(Fileupload.FileName);
                    Fileupload.PostedFile.SaveAs(Server.MapPath("~/Logo/") + filename);
                    string image = "~/Logo/" + filename.ToString();

                    UpdateBarangayData(txt_bname.Text, txt_city.Text, txt_district.Text, image);                
                }
                else
                {                    
                    UpdateBarangayData(txt_bname.Text, txt_city.Text, txt_district.Text, Session["LogoPath"].ToString());

                }
            }
        }

        void UpdateBarangayData(string b_name, string city, string district, string filename)
        {
            MySqlCommand cmd = new MySqlCommand("UPDATE barangay_info SET b_name = @b_name, city = @city, district = @district, b_logo = @b_logo WHERE id = @id", con);
            cmd.Parameters.AddWithValue("@id", 1);
            cmd.Parameters.AddWithValue("@b_name", b_name);
            cmd.Parameters.AddWithValue("@city", city);
            cmd.Parameters.AddWithValue("@district", district);
            cmd.Parameters.AddWithValue("@b_logo", filename);
            cmd.ExecuteNonQuery();
            refreshdata_Barangay();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully updated.";
        }

        
    }
}