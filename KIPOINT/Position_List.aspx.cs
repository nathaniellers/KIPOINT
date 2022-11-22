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
using MySqlX.XDevAPI.Relational;
using System.Xml.Linq;

namespace KIPOINT
{
    public partial class Position_List : System.Web.UI.Page
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
                dropdown_position();
                GetTerm(DateTime.Today);
            }
        }

        void load_data()
        {
            MySqlCommand cmd_load = new MySqlCommand("SELECT * FROM view_position", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                view_position.DataSource = dt;
                view_position.DataBind();
            }
        }

        void cleartext()
        {
            txt_fname.Text = "";
            txt_lname.Text = "";
            txt_mname.Text = "";
        }

        void dropdown_position()
        {
            using (MySqlCommand comr = new MySqlCommand("SELECT * FROM position ORDER BY prank asc ", con))
            {
                ddl_position.Items.Clear();
                comr.CommandType = CommandType.Text;
                comr.Connection = con;

                using (MySqlDataReader sdr_req = comr.ExecuteReader())
                {
                    while (sdr_req.Read())
                    {
                        ListItem item_req = new ListItem();
                        item_req.Text = sdr_req["pname"].ToString();
                        item_req.Value = sdr_req["id"].ToString();
                        ddl_position.Items.Add(item_req);
                    }
                    ddl_position.Items.Insert(0, new ListItem("--SELECT--", ""));
                }
            }
        }

        protected void ddl_position_SelectedIndexChanged(object sender, EventArgs e)
        {

            string qry = "SELECT plimit FROM position where id =@id ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@id", ddl_position.SelectedItem.Value);

            // MySqlDataReader sdr = cmd.ExecuteReader();
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                Session["position_limit"] = dt.Rows[0]["plimit"].ToString();
            }
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            Session["lbl_position"] = ((Label)view_position.Rows[e.NewEditIndex].FindControl("lbl_position")).Text;
            view_position.EditIndex = e.NewEditIndex;
            load_data();
        }
        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            Label1.Text = "";
            view_position.EditIndex = -1;
            load_data();
        }
        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(view_position.DataKeys[e.RowIndex].Values[0]);

            MySqlCommand cmd = new MySqlCommand("delete FROM user_position where id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            load_data();
        }



        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {                   
            GridViewRow row = view_position.Rows[e.RowIndex];
            int id = Convert.ToInt32(view_position.DataKeys[e.RowIndex].Values[0]);  
            DropDownList position = view_position.Rows[e.RowIndex].FindControl("ddl_position") as DropDownList;
            string lname = (row.FindControl("txt_lname") as TextBox).Text;
            string fname = (row.FindControl("txt_fname") as TextBox).Text;
            string mname = (row.FindControl("txt_mname") as TextBox).Text;
            DropDownList term = view_position.Rows[e.RowIndex].FindControl("ddl_term") as DropDownList;
            RadioButtonList status = view_position.Rows[e.RowIndex].FindControl("rb_status") as RadioButtonList;
            
            //checking for plimit of position selected.
            string qry = "SELECT position_id, COUNT(position_id) as position_count, plimit FROM view_position WHERE position_id=@position_id ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@position_id", position.SelectedValue);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            Session["position_count"] = dt.Rows[0]["position_count"].ToString();
            Session["position_limit"] = dt.Rows[0]["plimit"].ToString();
            Session["position_id"] = dt.Rows[0]["position_id"].ToString();
            int position_count = int.Parse((string)Session["position_count"]);
            int position_limit = int.Parse((string)Session["position_limit"]);        
            
            if (lname == "" || fname == "" || mname == "")
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing details! Kindly complete before you hit the button.";
            }
            else
            {
                if (position_count + 1 <= position_limit)
                {
                    UpdatePosition(id, fname, lname, mname, int.Parse(position.SelectedValue), int.Parse(status.SelectedValue));
                }
                else
                {
                    if (position.SelectedItem.Text == Session["lbl_position"].ToString())
                    {
                        UpdatePosition(id, fname, lname, mname, int.Parse(position.SelectedValue), int.Parse(status.SelectedValue));
                    }
                    else
                    {
                        Label1.ForeColor = System.Drawing.Color.Red;
                        Label1.Text = "The selected position is already reach the limit.";
                    }
                }
            }
        }

        void UpdatePosition(int id,string fname,string lname,string mname,int position, int status)
        {
            MySqlCommand cmd_edit = new MySqlCommand("UPDATE user_position SET  position_id=@position_id, lname=@lname, fname=@fname, mname=@mname, status=@status WHERE id = @id", con);

            cmd_edit.Parameters.AddWithValue("@id", id);
            cmd_edit.Parameters.AddWithValue("@fname", fname);
            cmd_edit.Parameters.AddWithValue("@lname", lname);
            cmd_edit.Parameters.AddWithValue("@mname", mname);
            cmd_edit.Parameters.AddWithValue("@position_id", position);
            cmd_edit.Parameters.AddWithValue("@status", status);
            cmd_edit.ExecuteNonQuery();
            view_position.EditIndex = -1;
            load_data();
            //cleartext();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully updated!";
        }


        void gridview_dropdown_position(GridViewRowEventArgs e)
        {
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM position ORDER BY prank asc ", con);
            MySqlDataAdapter oda = new MySqlDataAdapter(cmd);
            MySqlCommandBuilder builder = new MySqlCommandBuilder(oda);
            DataSet ds = new DataSet();
            oda.Fill(ds);

            DropDownList ddlreli = (DropDownList)e.Row.FindControl("ddl_position");

            if (ddlreli != null)
            {
                ddlreli.DataSource = ds;
                ddlreli.DataValueField = "id";
                ddlreli.DataTextField = "pname";
                ddlreli.DataBind();
            }
           ((DropDownList)e.Row.FindControl("ddl_position")).SelectedValue = DataBinder.Eval(e.Row.DataItem, "position_id").ToString();

        }

        void GetStatusData(GridViewRowEventArgs e)
        {         
            int StatusNo = (int)DataBinder.Eval(e.Row.DataItem, "ustatus");
            RadioButtonList RadioStatus = (RadioButtonList)e.Row.FindControl("rb_status");
            RadioStatus.Items.FindByValue(StatusNo.ToString()).Selected = true;
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            

            if ((e.Row.RowType == DataControlRowType.DataRow) && ((e.Row.RowState & DataControlRowState.Edit) > 0))
            {
                
                gridview_dropdown_position(e);
                GetStatusData(e); 
            }

            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != view_position.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            if (txt_fname.Text == "" || txt_lname.Text == "" || txt_mname.Text == "") 
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing details! Kindly complete before you hit the button.";
            }
            else
            {
                
                checking_plimit_of_user_in_position(Session["position_limit"], Add_position) ;
            }
        }

        void checking_plimit_of_user_in_position(object p_limit , Action method2)
        {
            //checking for plimit of position selected.
            string qry = "SELECT count(*) as 'position_count' FROM user_position where position_id =@position_id ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@position_id", ddl_position.SelectedItem.Value);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count <= 1)
            {
                Session["position_count"] = dt.Rows[0]["position_count"].ToString();

                int position_count = int.Parse((string)Session["position_count"]);
                int position_limit = int.Parse((string)p_limit);

                if (position_count + 1 <= position_limit)
                {

                    method2();
                }
                else
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "The selected position is already reach the limit.";
                }
            }
            else
            {
                method2();
            }
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            cleartext();
        }

        void Add_position()
        {
            MySqlCommand cmd_add = new MySqlCommand("INSERT INTO user_position (fname,lname,mname,position_id,term_id,status) VALUES (@fname,@lname,@mname,@position_id,@term_id,@status)", con);

            cmd_add.Parameters.AddWithValue("@fname", txt_fname.Text);
            cmd_add.Parameters.AddWithValue("@lname", txt_lname.Text);
            cmd_add.Parameters.AddWithValue("@mname", txt_mname.Text);
            cmd_add.Parameters.AddWithValue("@position_id", ddl_position.SelectedItem.Value);
            cmd_add.Parameters.AddWithValue("@term_id", 1);
            cmd_add.Parameters.AddWithValue("@status", 1);
            cmd_add.ExecuteNonQuery();

            load_data();

            cleartext();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully added!";
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        void GetTerm(DateTime todaydate)
        {
            string qry = "SELECT * FROM year_term where id=1 ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            //cmd.Parameters.Clear();
            //cmd.Parameters.AddWithValue("@position_id", ddl_position.SelectedItem.Value);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            DateTime start = DateTime.Parse(dt.Rows[0]["term_start"].ToString());
            DateTime end = DateTime.Parse(dt.Rows[0]["term_end"].ToString());

            if (todaydate >= start && todaydate <= end)
            {
                lbl_term.Text = "TERM: " + start.ToString("yyyy") + "-" + end.ToString("yyyy");
            }
            else
            {             
                lbl_term.Text = "Please update the TERM in Other Management";
                lbl_term.ForeColor = System.Drawing.Color.Red;
            }
        }     
    }
}