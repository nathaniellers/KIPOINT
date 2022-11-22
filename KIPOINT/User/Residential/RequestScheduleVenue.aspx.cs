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
using System.Web.Services;

namespace KIPOINT.User.Residential
{
    public partial class RequestScheduleVenue : System.Web.UI.Page
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
                LoadScheduleList();
                DropdownVenueForSearch();
                DropdownSchduleVenue();
            }

         }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            schedule_list.EditIndex = e.NewEditIndex;
            LoadScheduleList();
        }
        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            schedule_list.EditIndex = -1;
            LoadScheduleList();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(schedule_list.DataKeys[e.RowIndex].Values[0]);

            GridViewRow row = schedule_list.Rows[e.RowIndex];
            string status = (row.FindControl("lbl_status") as Label).Text;

            if (status == "Cancel")
            {
                MySqlCommand cmd = new MySqlCommand("delete FROM schedule_venue where id=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
                LoadScheduleList();

                MySqlCommand Eq_cmd = new MySqlCommand("delete FROM equipment_reservation where reserved_with=@reserved_with", con);
                Eq_cmd.Parameters.AddWithValue("@reserved_with", id);
                Eq_cmd.ExecuteNonQuery();
            }
            else
            {
                msg.ForeColor = System.Drawing.Color.Red;
                msg.Text = "The venue selected is not cancel.";
            }
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dr = (DataRowView)e.Row.DataItem;
                DateTime date_start = DateTime.Parse(dr["date_start"].ToString());
                DateTime date_end = DateTime.Parse(dr["date_end"].ToString());

                TimeSpan start = TimeSpan.Parse(dr["venue_start"].ToString());
                TimeSpan end = TimeSpan.Parse(dr["venue_end"].ToString());
                TimeSpan now = DateTime.Now.TimeOfDay;

                String v_status = dr["status"].ToString();


                if (v_status == "Disapproved")
                {
                    e.Row.Cells[9].Text = "Disapproved";
                    e.Row.Cells[9].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[9].ForeColor = System.Drawing.Color.White;
                }
                else if (v_status == "Cancel")
                {
                    e.Row.Cells[9].Text = "Cancel";
                    e.Row.Cells[9].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[9].ForeColor = System.Drawing.Color.White;
                }
                else if (v_status == "Rescheduled")
                {
                    e.Row.Cells[9].Text = "Rescheduled";
                    e.Row.Cells[9].BackColor = System.Drawing.Color.Aqua;
                    e.Row.Cells[9].ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    if ((DateTime.Today == date_start && DateTime.Today <= date_end) && (v_status == "Approved"))
                    {
                        if ((now >= start) && (now <= end))
                        {
                            e.Row.Cells[9].Text = "Active";
                            e.Row.Cells[9].BackColor = System.Drawing.Color.Green;
                            e.Row.Cells[9].ForeColor = System.Drawing.Color.Black;
                        }
                        else
                        {
                            if ((now <= start) && (now <= end))
                            {
                                e.Row.Cells[9].Text = "Incoming";
                                e.Row.Cells[9].BackColor = System.Drawing.Color.Yellow;
                                e.Row.Cells[9].ForeColor = System.Drawing.Color.Black;
                            }
                            else
                            {
                                e.Row.Cells[9].Text = "Completed";
                                e.Row.Cells[9].BackColor = System.Drawing.Color.Red;
                                e.Row.Cells[9].ForeColor = System.Drawing.Color.White;
                            }
                        }
                    }
                    else
                    {
                        if (DateTime.Today <= date_start && DateTime.Today <= date_end)
                        {
                            e.Row.Cells[9].Text = "Incoming";
                            e.Row.Cells[9].BackColor = System.Drawing.Color.Yellow;
                            e.Row.Cells[9].ForeColor = System.Drawing.Color.Black;
                        }
                        else
                        {
                            e.Row.Cells[9].Text = "Completed";
                            e.Row.Cells[9].BackColor = System.Drawing.Color.Red;
                            e.Row.Cells[9].ForeColor = System.Drawing.Color.White;
                        }

                    }

                }


            }

            //DeleteRow
            //if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != schedule_list.EditIndex)
            //{
            //    (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            //}
        }
        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = schedule_list.Rows[e.RowIndex];
            int id = Convert.ToInt32(schedule_list.DataKeys[e.RowIndex].Values[0]);
            string purpose = (row.FindControl("txt_purpose") as TextBox).Text;
            string remarks = (row.FindControl("txt_remarks") as TextBox).Text;


            MySqlCommand cmd_edit = new MySqlCommand("UPDATE schedule_venue SET   purpose=@purpose,  remarks=@remarks WHERE id = @id", con);

            var command = cmd_edit.Parameters;
            command.AddWithValue("@purpose", purpose);
            command.AddWithValue("@remarks", remarks);
            command.AddWithValue("@id", id);
            cmd_edit.ExecuteNonQuery();
            schedule_list.EditIndex = -1;
            LoadScheduleList();
            cleartext();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully updated!";
        }

        public void cleartext()
        {
            txt_timeend.Text = "";
            txt_purpose.Text = "";
            txt_timestart.Text = "";
            txt_remarks.Text = "";
            Label1.Text = "";
        }

        void LoadScheduleList()
        {
            MySqlCommand cmd_load = new MySqlCommand("SELECT * FROM view_venue WHERE reserved_by_id=@reserved_by_id ORDER BY date_start asc", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);
            cmd_load.Parameters.Clear();
            cmd_load.Parameters.AddWithValue("@reserved_by_id", Session["Resi_id"]);
            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                schedule_list.DataSource = dt;
                schedule_list.DataBind();
            }
        }

        void DropdownSchduleVenue()
        {
            try
            {
                using (MySqlCommand comr = new MySqlCommand("SELECT * FROM venue", con))
                {
                    Ddlist_Venue.Items.Clear();
                    comr.CommandType = CommandType.Text;
                    comr.Connection = con;

                    using (MySqlDataReader sdr_req = comr.ExecuteReader())
                    {
                        while (sdr_req.Read())
                        {
                            ListItem item_req = new ListItem();
                            item_req.Text = sdr_req["venue"].ToString();
                            item_req.Value = sdr_req["id"].ToString();
                            Ddlist_Venue.Items.Add(item_req);
                        }


                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        void DropdownVenueForSearch()
        {
            try
            {
                using (MySqlCommand comr = new MySqlCommand("SELECT * FROM venue", con))
                {                  
                    ddl_venue.Items.Clear();
                    comr.CommandType = CommandType.Text;
                    comr.Connection = con;

                    using (MySqlDataReader sdr_req = comr.ExecuteReader())
                    {

                        while (sdr_req.Read())
                        {
                            ListItem item_req = new ListItem();
                            item_req.Text = sdr_req["venue"].ToString();
                            item_req.Value = sdr_req["id"].ToString();
                            ddl_venue.Items.Add(item_req);
                        }

                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        void SearchVenue(string venue)
        {
            try
            {
                MySqlCommand cmd_load = new MySqlCommand("SELECT * from view_venue WHERE venue_id=@venue_id and reserved_by_id=@reserved_by_id ", con);
                cmd_load.Parameters.Clear();
                cmd_load.Parameters.AddWithValue("@venue_id", venue);
                cmd_load.Parameters.AddWithValue("@reserved_by_id", Session["Resi_id"]);
                MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);

                using (DataTable dt = new DataTable())
                {
                    d.Fill(dt);
                    schedule_list.DataSource = dt;
                    schedule_list.DataBind();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        void add_schedule()
        {
            GenerateID();

            MySqlCommand cmd_add = new MySqlCommand("INSERT INTO schedule_venue (req,venue_id,date_start,date_end,venue_start,venue_end,purpose,reserved_by,remarks) VALUES (@req,@venue_id,@date_start,@date_end,@venue_start,@venue_end,@purpose,@reserved_by,@remarks)", con);

            DateTime date_s = DateTime.ParseExact(txt_datestart.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            DateTime date_e = DateTime.ParseExact(txt_dateend.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);


            cmd_add.Parameters.AddWithValue("@req", Session["req"].ToString());
            cmd_add.Parameters.AddWithValue("@venue_id", ddl_venue.SelectedValue);
            cmd_add.Parameters.AddWithValue("@date_start", date_s);
            cmd_add.Parameters.AddWithValue("@date_end", date_e);
            cmd_add.Parameters.AddWithValue("@venue_start", txt_timestart.Text);
            cmd_add.Parameters.AddWithValue("@venue_end", txt_timeend.Text);
            cmd_add.Parameters.AddWithValue("@purpose", txt_purpose.Text);
            cmd_add.Parameters.AddWithValue("@reserved_by", Session["Resi_id"]);
            cmd_add.Parameters.AddWithValue("@remarks", txt_remarks.Text);
            cmd_add.ExecuteNonQuery();
            LoadScheduleList();
            cleartext();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully added!";
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        void DateTimeValidation(DateTime d_start, DateTime e_end, TimeSpan start, TimeSpan end, Action method)
        {
            string qry = "SELECT * FROM view_venue where venue_id =@venue_id ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@venue_id", ddl_venue.SelectedItem.Value);

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
                    TimeSpan time_start = TimeSpan.Parse(dt.Rows[i]["venue_start"].ToString());
                    TimeSpan time_end = TimeSpan.Parse(dt.Rows[i]["venue_end"].ToString());

                    if ((date_start == d_start) && (date_end <= e_end))
                    {
                        if ((time_start >= start && time_start <= end) || (time_end >= start && time_end <= end))
                        {
                            Label1.ForeColor = System.Drawing.Color.Red;
                            Label1.Text = "The venue selected is already have schedule.";
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

        void GenerateID()
        {
            try
            {
                string numbers = "1234567890";
                string characters = numbers;

                string id = string.Empty;
                for (int i = 0; i < 7; i++)
                {
                    string character = string.Empty;
                    do
                    {
                        int index = new Random().Next(0, characters.Length);
                        character = characters.ToCharArray()[index].ToString();
                    } while (id.IndexOf(character) != -1);
                    id += character;
                }
                Session["req"] = "REQ" + id;
            }
            catch (Exception e)
            {
                Debug.WriteLine(e.Message);
            }

        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            cleartext();
        }

        protected void btn_add_Click(object sender, EventArgs e)
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
                    DateTimeValidation(d_start, d_end, t_start, t_end, add_schedule);

                }
                else
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "DateTime start should be higher than end!";

                }
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            SearchVenue(Ddlist_Venue.SelectedValue);
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            LoadScheduleList();
        }


        public class SchdeduleVenue
        {
            public int id { get; set; }
            public string REQ { get; set; }
            public string venue { get; set; }
            public string date_start { get; set; }
            public string date_end { get; set; }
            public string venue_start { get; set; }
            public string venue_end { get; set; }
            public string status { get; set; }
            public string purpose { get; set; }
        }


        [WebMethod]
        public static List<SchdeduleVenue> GetScheduleVenuePerId(string venue_id)
        {
            List<SchdeduleVenue> sv = new List<SchdeduleVenue>();

            string con = ConfigurationManager.ConnectionStrings["MyDB"].ToString();
            using (MySqlConnection conn = new MySqlConnection(con))
            {
                using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM view_venue where venue_id=@venue_id and status!='Cancel'", conn))
                {
                    cmd.Parameters.AddWithValue("venue_id", venue_id);
                    conn.Open();
                    MySqlDataReader rd = cmd.ExecuteReader();
                    if (rd.HasRows)
                    {
                        while (rd.Read())
                        {
                            SchdeduleVenue s = new SchdeduleVenue();
                            s.id = Convert.ToInt32(rd["id"].ToString());
                            s.REQ = rd["REQ"].ToString();
                            s.venue = rd["venue"].ToString();
                            s.date_start = rd["date_start"].ToString();
                            s.date_end = rd["date_end"].ToString();
                            s.venue_start = rd["venue_start"].ToString();
                            s.venue_end = rd["venue_end"].ToString();
                            s.status = rd["status"].ToString();
                            s.purpose = rd["purpose"].ToString();
                            sv.Add(s);
                        }
                    }
                }
            }
            return sv;
        }



    }
}