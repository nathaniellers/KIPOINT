using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using MySql.Data.Types;
using MySql.Data;
using System.Configuration;
using System.Text;
using System.Web.Services;
using Newtonsoft.Json;
using System.Web.Script.Serialization;

namespace KIPOINT
{
    public partial class _Default : Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Close();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            if(!this.IsPostBack)
            {
                load_data();
              
            }

           
        }

        void load_data()
        {
            MySqlCommand cmd_load = new MySqlCommand("SELECT * FROM view_venue", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                schedule_list.DataSource = dt;
                schedule_list.DataBind();
            }
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
        public static List<SchdeduleVenue> GetScheduleVenue()
        {
          
            List<SchdeduleVenue> sv = new List<SchdeduleVenue>();

            string con = ConfigurationManager.ConnectionStrings["MyDB"].ToString();
            using (MySqlConnection conn = new MySqlConnection(con))
            {
                using (MySqlCommand cmd = new MySqlCommand("SELECT * FROM view_venue", conn))
                {
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