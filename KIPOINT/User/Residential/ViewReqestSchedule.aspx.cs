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
    public partial class ViewReqestSchedule : System.Web.UI.Page
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
                FetchEquipment();
                FetchScheduleData();
                LoadReservedtList();
            }

        }

        void LoadReservedtList()
        {
            MySqlCommand cmd_load = new MySqlCommand("SELECT * FROM view_reservation WHERE reserved_with=@reserved_with", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);
            cmd_load.Parameters.Clear();
            cmd_load.Parameters.AddWithValue("@reserved_with", HttpUtility.UrlDecode(Request.QueryString["id"]));
            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                reserve_list.DataSource = dt;
                reserve_list.DataBind();
            }
        }

        void FetchEquipment()
        {
            using (MySqlCommand comr = new MySqlCommand("SELECT * FROM equipment", con))
            {
                DrpEquipment.Items.Clear();
                comr.CommandType = CommandType.Text;
                comr.Connection = con;

                using (MySqlDataReader sdr_req = comr.ExecuteReader())
                {

                    while (sdr_req.Read())
                    {
                        ListItem item_req = new ListItem();
                        item_req.Text = (sdr_req["eq_name"].ToString() + " - " + sdr_req["eq_num"].ToString());
                        item_req.Value = sdr_req["id"].ToString();
                        DrpEquipment.Items.Add(item_req);
                    }
                }
            }
        }

        void FetchScheduleData()
        {
            string qry = "SELECT * FROM view_venue WHERE id=@id";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@id", HttpUtility.UrlDecode(Request.QueryString["id"]));

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                Session["eq_req"] = dt.Rows[0]["req"].ToString();
                txt_req.Text = dt.Rows[0]["req"].ToString();
                txt_venue.Text = dt.Rows[0]["venue"].ToString();
                txt_purpose.Text = dt.Rows[0]["purpose"].ToString();
                txt_datestart.Text = dt.Rows[0]["date_start"].ToString();
                txt_dateend.Text = dt.Rows[0]["date_end"].ToString();
                txt_timestart.Text = dt.Rows[0]["venue_start"].ToString();
                txt_timeend.Text = dt.Rows[0]["venue_end"].ToString();
                txt_reserve.Text = dt.Rows[0]["reserved_by"].ToString();
                txt_remarks.Text = dt.Rows[0]["remarks"].ToString();
                lbl_status.Text = dt.Rows[0]["status"].ToString();
                txt_reserverid.Text = dt.Rows[0]["reserved_by_id"].ToString();

                if (lbl_status.Text == "Approved")
                {
                    lbl_status.ForeColor = System.Drawing.Color.LimeGreen;
                    btn_ok.Visible = false;                   

                    btn_Add_Equipemt.Visible = false;
                    DrpEquipment.Enabled = false;
                    reserve_list.Enabled = false;
                }
                else if (lbl_status.Text == "Disapproved")
                {
                    lbl_status.ForeColor = System.Drawing.Color.Red;
                    btn_ok.Visible = false;

                    btn_Add_Equipemt.Visible = false;
                    DrpEquipment.Enabled = false;
                    reserve_list.Enabled = false;
                }
                else if (lbl_status.Text == "Pending")
                {
                    lbl_status.ForeColor = System.Drawing.Color.Yellow;
                    btn_ok.Visible = false;
                }
                else if (lbl_status.Text == "Cancel")
                {
                    lbl_status.ForeColor = System.Drawing.Color.Red;
                    btn_ok.Visible = false;
                    btn_reschedule.Visible = false;

                    btn_Add_Equipemt.Visible = false;
                    DrpEquipment.Enabled = false;
                    reserve_list.Enabled = false;
                }
                else
                {
                    lbl_status.ForeColor = System.Drawing.Color.Aqua;
                    btn_ok.Visible = false;
                   
                    
                }
            }
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(reserve_list.DataKeys[e.RowIndex].Values[0]);

            MySqlCommand cmd = new MySqlCommand("delete FROM equipment_reservation where id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            LoadReservedtList();
            FetchEquipment();
        }

        void UpdateScheduleStatus(string status)
        {
            MySqlCommand cmd_edit = new MySqlCommand("UPDATE schedule_venue SET status=@status WHERE id = @id", con);

            var command = cmd_edit.Parameters;
            command.AddWithValue("@status", status);
            command.AddWithValue("@id", HttpUtility.UrlDecode(Request.QueryString["id"]));
            cmd_edit.ExecuteNonQuery();
            FetchScheduleData();
        }

        void UpdateEquipmentStatus(string status)
        {
            MySqlCommand cmd_edit = new MySqlCommand("UPDATE equipment_reservation SET status=@status WHERE reserved_with = @reserved_with", con);

            var command = cmd_edit.Parameters;
            command.AddWithValue("@status", status);
            command.AddWithValue("@reserved_with", HttpUtility.UrlDecode(Request.QueryString["id"]));
            cmd_edit.ExecuteNonQuery();
            FetchScheduleData();
        }

        void ReschduleVenue()
        {
            MySqlCommand cmd_edit = new MySqlCommand("UPDATE schedule_venue SET date_start=@date_start, date_end=@date_end, venue_start=@venue_start,venue_end=@venue_end ,purpose=@purpose , remarks=@remarks WHERE id = @id", con);

            DateTime date_s = DateTime.ParseExact(txt_datestart.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            DateTime date_e = DateTime.ParseExact(txt_dateend.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            var command = cmd_edit.Parameters;
            command.AddWithValue("@purpose", txt_purpose.Text);
            command.AddWithValue("@remarks", txt_remarks.Text);
            command.AddWithValue("@date_start", date_s);
            command.AddWithValue("@date_end", date_e);
            command.AddWithValue("@venue_start", txt_timestart.Text);
            command.AddWithValue("@venue_end", txt_timeend.Text);
            command.AddWithValue("@id", HttpUtility.UrlDecode(Request.QueryString["id"]));
            cmd_edit.ExecuteNonQuery();
            Label1.ForeColor = System.Drawing.Color.LimeGreen;
            Label1.Text = "Successfully submitted.";
            UpdateScheduleStatus("Rescheduled");
            UpdateEquipmentStatus("Rescheduled");
            btn_ok.Visible = false;
            btn_reschedule.Visible = true;
            txt_purpose.Enabled = false;
            txt_dateend.Enabled = false;
            txt_datestart.Enabled = false;
            txt_timeend.Enabled = false;
            txt_timestart.Enabled = false;
            txt_remarks.Enabled = false;
        }

        protected void btn_ok_Click(object sender, EventArgs e)
        {
            if (btn_ok.Text == "Submit")
            {             
                if (txt_purpose.Text == "" | txt_timeend.Text == "" | txt_remarks.Text == "" | txt_timestart.Text == "")
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

                    if ((d_start <= d_end) && (t_start < t_end))
                    {
                        string qry = "SELECT * FROM view_venue where venue_id =@venue_id ";
                        MySqlCommand cmd = new MySqlCommand(qry, con);
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@venue_id", txt_id.Text);

                        MySqlDataAdapter d = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        d.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            ReschduleVenue();
                        }
                        else
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                DateTime date_start = DateTime.Parse(dt.Rows[i]["date_start"].ToString());
                                DateTime date_end = DateTime.Parse(dt.Rows[i]["date_end"].ToString());
                                TimeSpan time_start = TimeSpan.Parse(dt.Rows[i]["venue_start"].ToString());
                                TimeSpan time_end = TimeSpan.Parse(dt.Rows[i]["venue_end"].ToString());

                                if ((date_start == DateTime.Parse(txt_datestart.Text)) && (date_end <= DateTime.Parse(txt_dateend.Text)))
                                {
                                    if ((time_start >= TimeSpan.Parse(txt_timestart.Text) && time_start <= TimeSpan.Parse(txt_timeend.Text)) || (time_end >= TimeSpan.Parse(txt_timestart.Text) && time_end <= TimeSpan.Parse(txt_timeend.Text)))
                                    {
                                        Label1.ForeColor = System.Drawing.Color.Red;
                                        Label1.Text = "The venue selected is already have schedule.";
                                        break;
                                    }
                                    else
                                    {
                                        ReschduleVenue();
                                    }
                                }
                                else
                                {
                                    ReschduleVenue();
                                }
                            }
                        }
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
            txt_datestart.Enabled = true;
            txt_dateend.Enabled = true;
            txt_timestart.Enabled = true;
            txt_timeend.Enabled = true;
            txt_purpose.Enabled = true;
            txt_remarks.Enabled = true;
            btn_reschedule.Visible = false;
            btn_ok.Visible = true;
            btn_Add_Equipemt.Visible = true;
            DrpEquipment.Enabled = true;
            reserve_list.Enabled = true;
            btn_ok.Text = "Submit";
            lbl_status.ForeColor = System.Drawing.Color.Aqua;
            lbl_status.Text = "Rescheduled";
           
        }

        void ReservedEQuipment()
        {
            MySqlCommand cmd_add = new MySqlCommand("INSERT INTO equipment_reservation (eq_id,date_start,date_end,time_start,time_end,purpose,reserved_by,remarks,reserved_with,status,eq_req) VALUES (@eq_id,@date_start,@date_end,@time_start,@time_end,@purpose,@reserved_by,@remarks,@reserved_with,@status,@eq_req)", con);

            DateTime date_s = DateTime.ParseExact(txt_datestart.Text, "yyyy-MM-dd", null);
            DateTime date_e = DateTime.ParseExact(txt_dateend.Text, "yyyy-MM-dd", null);
            cmd_add.Parameters.AddWithValue("@eq_req", Session["eq_req"]);
            cmd_add.Parameters.AddWithValue("@eq_id", DrpEquipment.SelectedValue);
            cmd_add.Parameters.AddWithValue("@date_start", date_s);
            cmd_add.Parameters.AddWithValue("@date_end", date_e);
            cmd_add.Parameters.AddWithValue("@time_start", txt_timestart.Text);
            cmd_add.Parameters.AddWithValue("@time_end", txt_timeend.Text);
            cmd_add.Parameters.AddWithValue("@purpose", txt_purpose.Text);
            cmd_add.Parameters.AddWithValue("@reserved_by", txt_reserverid.Text);
            cmd_add.Parameters.AddWithValue("@remarks", txt_remarks.Text);
            cmd_add.Parameters.AddWithValue("@status", lbl_status.Text);
            cmd_add.Parameters.AddWithValue("@reserved_with", HttpUtility.UrlDecode(Request.QueryString["id"]));
            cmd_add.ExecuteNonQuery();
            LoadReservedtList();
            FetchEquipment();
            Label1.Text = "";
            
        }

        protected void btn_Add_Equipemt_Click(object sender, EventArgs e)
        {
            string qry = "SELECT * FROM equipment_reservation WHERE eq_id=@eq_id";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@eq_id", DrpEquipment.SelectedValue);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                ReservedEQuipment();
            }
            else
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DateTime date_start = DateTime.Parse(dt.Rows[i]["date_start"].ToString());
                    DateTime date_end = DateTime.Parse(dt.Rows[i]["date_end"].ToString());
                    TimeSpan time_start = TimeSpan.Parse(dt.Rows[i]["time_start"].ToString());
                    TimeSpan time_end = TimeSpan.Parse(dt.Rows[i]["time_end"].ToString());

                    if ((date_start == DateTime.Parse(txt_datestart.Text)) && (date_end <= DateTime.Parse(txt_dateend.Text)))
                    {
                        if ((time_start >= TimeSpan.Parse(txt_timestart.Text) && time_start <= TimeSpan.Parse(txt_timeend.Text)) || (time_end >= TimeSpan.Parse(txt_timestart.Text) && time_end <= TimeSpan.Parse(txt_timeend.Text)))
                        {
                            Label1.ForeColor = System.Drawing.Color.Red;
                            Label1.Text = "The equipment selected is already have reserved.";
                            break;
                        }
                        else
                        {
                            ReservedEQuipment();
                        }
                    }
                    else
                    {
                        ReservedEQuipment();
                    }
                }
            }
        }


    }
 }
