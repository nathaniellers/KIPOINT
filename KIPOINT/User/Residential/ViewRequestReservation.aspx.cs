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
using System.Globalization;
using System.Diagnostics;
using System.Text;

namespace KIPOINT.User.Residential
{
    public partial class ViewRequestReservation : System.Web.UI.Page
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
                FetchReservation();
                
            }
        }

        void FetchReservation()
        {
            string qry = "SELECT * FROM view_reservation WHERE reserved_with=0 and id=@id";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@id", HttpUtility.UrlDecode(Request.QueryString["id"]));

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                Session["eq_id"] = dt.Rows[0]["eq_id"].ToString();
                txt_req.Text = dt.Rows[0]["eq_req"].ToString();
                txt_equipment.Text = dt.Rows[0]["eq_name"].ToString();
                txt_eq_num.Text = dt.Rows[0]["eq_num"].ToString();
                txt_brand.Text = dt.Rows[0]["eq_brand"].ToString();
                txt_purpose.Text = dt.Rows[0]["purpose"].ToString();
                txt_datestart.Text = dt.Rows[0]["date_start"].ToString();
                txt_dateend.Text = dt.Rows[0]["date_end"].ToString();
                txt_timestart.Text = dt.Rows[0]["time_start"].ToString();
                txt_timeend.Text = dt.Rows[0]["time_end"].ToString();
                txt_reservedby.Text = dt.Rows[0]["reserved_by"].ToString();
                txt_remarks.Text = dt.Rows[0]["remarks"].ToString();
                lbl_status.Text = dt.Rows[0]["status"].ToString();


                if (lbl_status.Text == "Approved")
                {
                    lbl_status.ForeColor = System.Drawing.Color.LimeGreen;
                    btn_approve.Visible = false;
                   
                    btn_reschedule.Visible = true;
                    txt_datestart.Enabled = false;
                    txt_dateend.Enabled = false;
                    txt_timestart.Enabled = false;
                    txt_timeend.Enabled = false;
                   

                }
                else if (lbl_status.Text == "Disapproved")
                {
                    lbl_status.ForeColor = System.Drawing.Color.Red;
                    btn_approve.Visible = false;
                    txt_purpose.Enabled = false;
                    txt_remarks.Enabled = false;
                }
                else if (lbl_status.Text == "Rescheduled")
                {
                    lbl_status.ForeColor = System.Drawing.Color.Aqua;
                    btn_approve.Text = "Save";
                    btn_reschedule.Visible = true;
                }
                else if (lbl_status.Text == "Cancel")
                {
                    lbl_status.ForeColor = System.Drawing.Color.Red;
                    btn_approve.Visible = false;
                    btn_reschedule.Visible = false;
                    txt_purpose.Enabled = false;
                    txt_remarks.Enabled = false;
                   
                }
                else if (lbl_status.Text == "Pending")
                {
                    lbl_status.ForeColor = System.Drawing.Color.Yellow;
                }
            }
        }

        void UpdateOtherField(string purpose,string remarks)
        {
            MySqlCommand cmd_edit = new MySqlCommand("UPDATE equipment_reservation SET purpose=@purpose ,remarks=@remarks  WHERE id = @id", con);

            var command = cmd_edit.Parameters;
            command.AddWithValue("@purpose", purpose);
            command.AddWithValue("@remarks", remarks);
            command.AddWithValue("@id", HttpUtility.UrlDecode(Request.QueryString["id"]));
            cmd_edit.ExecuteNonQuery();
            FetchReservation();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully Save";
        }


        void DateTimeValidation(DateTime d_start, DateTime e_end, TimeSpan start, TimeSpan end, Action method)
        {
            string qry = "SELECT * FROM view_reservation where eq_id !=@eq_id ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@eq_id", Session["eq_id"]);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                method();
            }
            else
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DateTime date_start = DateTime.Parse(dt.Rows[i]["date_start"].ToString());
                    DateTime date_end = DateTime.Parse(dt.Rows[i]["date_end"].ToString());
                    TimeSpan time_start = TimeSpan.Parse(dt.Rows[i]["time_start"].ToString());
                    TimeSpan time_end = TimeSpan.Parse(dt.Rows[i]["time_end"].ToString());

                    if ((date_start == d_start) && (date_end <= e_end))
                    {

                        if ((time_start >= start && time_start <= end) || (time_end >= start && time_end <= end))
                        {
                            Label1.ForeColor = System.Drawing.Color.Red;
                            Label1.Text = "The equipment selected is already have schedule.";
                            break;
                        }
                        else
                        {
                            method();
                        }
                    }
                    else
                    {
                        method();
                    }
                }
            }

        }

        void UpdateReservation()
        {
            MySqlCommand cmd_edit = new MySqlCommand("UPDATE equipment_reservation SET purpose=@purpose, date_start=@date_start, date_end=@date_end, time_start=@time_start, time_end=@time_end, remarks=@remarks , status=@status WHERE id = @id", con);

            DateTime date_s = DateTime.ParseExact(txt_datestart.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            DateTime date_e = DateTime.ParseExact(txt_dateend.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            var command = cmd_edit.Parameters;
            command.AddWithValue("@purpose", txt_purpose.Text);
            command.AddWithValue("@date_start", date_s);
            command.AddWithValue("@date_end", date_e);
            command.AddWithValue("@time_start", txt_timestart.Text);
            command.AddWithValue("@time_end", txt_timeend.Text);
            command.AddWithValue("@remarks", txt_remarks.Text);
            command.AddWithValue("@status", "Rescheduled");
            command.AddWithValue("@id", HttpUtility.UrlDecode(Request.QueryString["id"]));
            cmd_edit.ExecuteNonQuery();
            lbl_status.ForeColor = System.Drawing.Color.Aqua;
            lbl_status.Text = "Rescheduled";
            
            txt_datestart.Enabled = false;
            txt_dateend.Enabled = false;
            txt_timeend.Enabled = false;
            txt_timestart.Enabled = false;
            btn_approve.Text = "Save";
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully Rescheduled";
        }


        protected void btn_approve_Click(object sender, EventArgs e)
        {
            if (btn_approve.Text == "Save")
            {
                UpdateOtherField(txt_purpose.Text, txt_remarks.Text);
            }
            else
            {
                if (txt_purpose.Text == "" || txt_timeend.Text == "" || txt_remarks.Text == "" || txt_timestart.Text == "" || txt_datestart.Text == "" || txt_dateend.Text == "")
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Missing details. Kindly complete it!";
                }
                else
                {
                    DateTime d_start = DateTime.Parse(txt_datestart.Text);
                    DateTime d_end = DateTime.Parse(txt_dateend.Text);
                    TimeSpan t_start = TimeSpan.Parse(txt_timestart.Text);
                    TimeSpan t_end = TimeSpan.Parse(txt_timeend.Text);

                    if ((d_start < d_end) || (t_start < t_end))
                    {
                        DateTimeValidation(d_start, d_end, t_start, t_end, UpdateReservation);
                    }
                    else
                    {
                        Label1.ForeColor = System.Drawing.Color.Red;
                        Label1.Text = "DateTime start should be higher than end!";
                    }
                }
            }
        }


        protected void btn_reschedule_Click(object sender, EventArgs e)
        {
            lbl_status.ForeColor = System.Drawing.Color.Aqua;
            lbl_status.Text = "Rescheduled";
            txt_purpose.Enabled = true;
            txt_remarks.Enabled = true;
            txt_dateend.Enabled = true;
            txt_datestart.Enabled = true;
            txt_timeend.Enabled = true;
            txt_timestart.Enabled = true;
            btn_reschedule.Visible = false;
            btn_approve.Visible = true;
            btn_approve.Text = "Submit";
        }
    }
}