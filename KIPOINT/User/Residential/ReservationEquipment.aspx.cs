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
    public partial class ReservationEquipment : System.Web.UI.Page
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
                DropdownEquipment();              
                DropdownEquipmentInSearch();
            }
        }


        void load_data()
        {
            MySqlCommand cmd_load = new MySqlCommand("SELECT * FROM view_reservation  WHERE reserved_with = 0 and reserved_by_id=@reserved_by_id ORDER BY date_start asc", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);
            cmd_load.Parameters.Clear();
            cmd_load.Parameters.AddWithValue("@reserved_by_id", Session["resi_id"]);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                equipment_list.DataSource = dt;
                equipment_list.DataBind();
            }
        }

        void cleartext()
        {
            txt_timeend.Text = "";
            txt_purpose.Text = "";
            txt_timestart.Text = "";
            txt_remarks.Text = "";
        }

        void DropdownEquipment()
        {
            using (MySqlCommand comr = new MySqlCommand("SELECT * FROM equipment", con))
            {
                ddl_equipment.Items.Clear();
                comr.CommandType = CommandType.Text;
                comr.Connection = con;


                using (MySqlDataReader sdr_req = comr.ExecuteReader())
                {

                    while (sdr_req.Read())
                    {
                        ListItem item_req = new ListItem();
                        item_req.Text = (sdr_req["eq_name"].ToString() + " - " + sdr_req["eq_num"].ToString());
                        item_req.Value = sdr_req["id"].ToString();
                        ddl_equipment.Items.Add(item_req);
                    }
                }
            }
        }

        void DropdownEquipmentInSearch()
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



        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            equipment_list.EditIndex = e.NewEditIndex;
            load_data();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            equipment_list.EditIndex = -1;
            load_data();

        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(equipment_list.DataKeys[e.RowIndex].Values[0]);

            GridViewRow row = equipment_list.Rows[e.RowIndex];
            string status = (row.FindControl("lbl_status") as Label).Text;

            if (status == "Cancel")
            {
                MySqlCommand cmd = new MySqlCommand("delete FROM equipment_reservation where id=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
                load_data();
            }
            else
            {
                Label2.ForeColor = System.Drawing.Color.Red;
                Label2.Text = "The selected reservation is not cancel.";
                //}
            }
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dr = (DataRowView)e.Row.DataItem;
                DateTime date_start = DateTime.Parse(dr["date_start"].ToString());
                DateTime date_end = DateTime.Parse(dr["date_end"].ToString());

                TimeSpan start = TimeSpan.Parse(dr["time_start"].ToString());
                TimeSpan end = TimeSpan.Parse(dr["time_end"].ToString());
                TimeSpan now = DateTime.Now.TimeOfDay;

                String v_status = dr["status"].ToString();

                if (v_status == "Disapproved")
                {
                    e.Row.Cells[11].Text = "Disapproved";
                    e.Row.Cells[11].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[11].ForeColor = System.Drawing.Color.White;
                }
                else if (v_status == "Cancel")
                {
                    e.Row.Cells[11].Text = "Cancel";
                    e.Row.Cells[11].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[11].ForeColor = System.Drawing.Color.White;
                }
                else if (v_status == "Rescheduled")
                {
                    e.Row.Cells[11].Text = "Rescheduled";
                    e.Row.Cells[11].BackColor = System.Drawing.Color.Aqua;
                    e.Row.Cells[11].ForeColor = System.Drawing.Color.Black;
                }

                else
                {
                    if ((DateTime.Today == date_start && DateTime.Today <= date_end) && (v_status == "Approved"))
                    {
                        if ((now >= start) && (now <= end))
                        {
                            e.Row.Cells[11].Text = "Active";
                            e.Row.Cells[11].BackColor = System.Drawing.Color.Green;
                            e.Row.Cells[11].ForeColor = System.Drawing.Color.Black;
                        }
                        else
                        {
                            if ((now <= start) && (now <= end))
                            {
                                e.Row.Cells[11].Text = "Incoming";
                                e.Row.Cells[11].BackColor = System.Drawing.Color.Yellow;
                                e.Row.Cells[11].ForeColor = System.Drawing.Color.Black;
                            }
                            else
                            {
                                e.Row.Cells[11].Text = "Completed";
                                e.Row.Cells[11].BackColor = System.Drawing.Color.Red;
                                e.Row.Cells[11].ForeColor = System.Drawing.Color.White;
                            }
                        }
                    }
                    else
                    {
                        if (DateTime.Today <= date_start && DateTime.Today <= date_end)
                        {
                            e.Row.Cells[11].Text = "Incoming";
                            e.Row.Cells[11].BackColor = System.Drawing.Color.Yellow;
                            e.Row.Cells[11].ForeColor = System.Drawing.Color.Black;
                        }
                        else
                        {
                            e.Row.Cells[11].Text = "Completed";
                            e.Row.Cells[11].BackColor = System.Drawing.Color.Red;
                            e.Row.Cells[11].ForeColor = System.Drawing.Color.White;
                        }

                    }

                }
            }

            //if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != equipment_list.EditIndex)
            //{
            //    (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            //}
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = equipment_list.Rows[e.RowIndex];
            int id = Convert.ToInt32(equipment_list.DataKeys[e.RowIndex].Values[0]);

            string purpose = (row.FindControl("txt_purpose") as TextBox).Text;
            string remarks = (row.FindControl("txt_remarks") as TextBox).Text;


            MySqlCommand cmd_edit = new MySqlCommand("UPDATE equipment_reservation SET purpose=@purpose, remarks=@remarks WHERE id = @id", con);

            var command = cmd_edit.Parameters;
            command.AddWithValue("@purpose", purpose);
            command.AddWithValue("@remarks", remarks);
            command.AddWithValue("@id", id);

            cmd_edit.ExecuteNonQuery();
            equipment_list.EditIndex = -1;
            load_data();
            cleartext();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully updated!";

        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            cleartext();
        }

        protected void btn_add_Click(object sender, EventArgs e)
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
                    DateTimeValidation(d_start, d_end, t_start, t_end, add_schedule);
                }
                else
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "DateTime start should be higher than end!";
                }
            }
        }

        void add_schedule()
        {

            GenerateID();
            MySqlCommand cmd_add = new MySqlCommand("INSERT INTO equipment_reservation (eq_id,date_start,date_end,time_start,time_end,purpose,reserved_by,remarks,eq_req) VALUES (@eq_id,@date_start,@date_end,@time_start,@time_end,@purpose,@reserved_by,@remarks,@eq_req)", con);

            DateTime date_s = DateTime.ParseExact(txt_datestart.Text, "yyyy-MM-dd", null);
            DateTime date_e = DateTime.ParseExact(txt_dateend.Text, "yyyy-MM-dd", null);

            cmd_add.Parameters.AddWithValue("@eq_req", Session["req"].ToString());
            cmd_add.Parameters.AddWithValue("@eq_id", ddl_equipment.SelectedValue);
            cmd_add.Parameters.AddWithValue("@date_start", date_s);
            cmd_add.Parameters.AddWithValue("@date_end", date_e);
            cmd_add.Parameters.AddWithValue("@time_start", txt_timestart.Text);
            cmd_add.Parameters.AddWithValue("@time_end", txt_timeend.Text);
            cmd_add.Parameters.AddWithValue("@purpose", txt_purpose.Text);
            cmd_add.Parameters.AddWithValue("@reserved_by", Session["resi_id"]);
            cmd_add.Parameters.AddWithValue("@remarks", txt_remarks.Text);
            cmd_add.ExecuteNonQuery();
            load_data();
            cleartext();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully added!";
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        void DateTimeValidation(DateTime d_start, DateTime e_end, TimeSpan start, TimeSpan end, Action method)
        {
            string qry = "SELECT * FROM view_reservation where eq_id =@eq_id ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@eq_id", ddl_equipment.SelectedItem.Value);

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

        void SearchReservation(string equipment)
        {
            try
            {
                MySqlCommand cmd_load = new MySqlCommand("SELECT * FROM view_reservation WHERE reserved_with = 0 and eq_id=@eq_id ", con);
                cmd_load.Parameters.Clear();
                cmd_load.Parameters.AddWithValue("@eq_id", equipment);
                MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);

                using (DataTable dt = new DataTable())
                {
                    d.Fill(dt);
                    equipment_list.DataSource = dt;
                    equipment_list.DataBind();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            SearchReservation(DrpEquipment.SelectedValue);
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            load_data();
        }



        public class ReservationEquipt
        {
            public int id { get; set; }
            public string REQ { get; set; }
            public string venue { get; set; }
            public string date_start { get; set; }
            public string date_end { get; set; }
            public string status { get; set; }
            public string purpose { get; set; }
        }


        [WebMethod]
        public static List<ReservationEquipt> GetReservationId(string eq_id)
        {
            List<ReservationEquipt> rs = new List<ReservationEquipt>();

            string con = ConfigurationManager.ConnectionStrings["MyDB"].ToString();
            using (MySqlConnection conn = new MySqlConnection(con))
            {
                using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM view_reservation where eq_id=@eq_id and status!='Cancel'", conn))
                {
                    cmd.Parameters.AddWithValue("eq_id", eq_id);
                    conn.Open();
                    MySqlDataReader rd = cmd.ExecuteReader();
                    if (rd.HasRows)
                    {
                        while (rd.Read())
                        {
                            ReservationEquipt r = new ReservationEquipt();
                            r.id = Convert.ToInt32(rd["id"].ToString());
                            r.REQ = rd["eq_req"].ToString();
                            r.venue = rd["eq_name"].ToString() + "-" + rd["eq_num"].ToString();
                            r.date_start = rd["date_start"].ToString() + "T" + rd["time_start"].ToString();
                            r.date_end = rd["date_end"].ToString() + "T" + rd["time_end"].ToString();
                            r.status = rd["status"].ToString();
                            r.purpose = rd["purpose"].ToString();
                            rs.Add(r);
                        }
                    }
                }
            }
            return rs;
        }



    }
}