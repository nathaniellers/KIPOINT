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
using System.Web.Services;

namespace KIPOINT
{


    public partial class Resident_List : System.Web.UI.Page
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
                dropdown_religion();
            }
        }

        void load_data()
        {
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM view_residential", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                residentialList.DataSource = dt;
                residentialList.DataBind();
            }
        }

        void dropdown_religion()
        {


            using (MySqlCommand com_id = new MySqlCommand("select id , religion_name from religion", con))
            {
                com_id.CommandType = CommandType.Text;
                com_id.Connection = con;

                using (MySqlDataReader sdr_id = com_id.ExecuteReader())
                {

                    while (sdr_id.Read())
                    {
                        ListItem item_id = new ListItem();
                        item_id.Text = sdr_id["religion_name"].ToString();
                        item_id.Value = sdr_id["id"].ToString();
                        religion.Items.Add(item_id);


                    }
                }
                religion.Items.Insert(0, new ListItem("--SELECT--", "0"));
            }
        }


        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            residentialList.EditIndex = e.NewEditIndex;
            load_data();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            residentialList.EditIndex = -1;
            load_data();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(residentialList.DataKeys[e.RowIndex].Values[0]);         
            if (ValidateRegisteredResidentials(id) == true)
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Can't delete selected residential as its already active as user.";
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("delete FROM residential_list where id=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
                load_data();
            }
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            GridViewRow row = residentialList.Rows[e.RowIndex];

            int id = Convert.ToInt32(residentialList.DataKeys[e.RowIndex].Values[0]);

            string lname = (row.FindControl("TextBox1") as TextBox).Text;
            string fname = (row.FindControl("TextBox2") as TextBox).Text;
            string mi = (row.FindControl("TextBox3") as TextBox).Text;
            DropDownList gender = residentialList.Rows[e.RowIndex].FindControl("DropDownList1") as DropDownList;
            DropDownList mstatus = residentialList.Rows[e.RowIndex].FindControl("DropDownList2") as DropDownList;
            string houseno = (row.FindControl("TextBox4") as TextBox).Text;
            string street = (row.FindControl("TextBox5") as TextBox).Text;
            DropDownList zone = residentialList.Rows[e.RowIndex].FindControl("DropDownList3") as DropDownList;
            string bday = (row.FindControl("TextBox6") as TextBox).Text;

            string bplace = (row.FindControl("TextBox7") as TextBox).Text;
            DropDownList religion = residentialList.Rows[e.RowIndex].FindControl("DropDownList4") as DropDownList;
            string occupation = (row.FindControl("TextBox8") as TextBox).Text;

            if (bday == "")
            {
                Response.Write("<script>alert('Please complete all the inputs');</script>");
            }
            else
            {
                MySqlCommand cmd = new MySqlCommand("UPDATE residential_list SET fname = @fname, lname = @lname, mi = @mi, gender = @gender, marital_status = @marital_status , household_no=@household_no , street=@street , zone=@zone, bday=@bday , bplace=@bplace , religion=@religion, occupation=@occupation WHERE id = @id", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@fname", fname);
                cmd.Parameters.AddWithValue("@lname", lname);
                cmd.Parameters.AddWithValue("@mi", mi);
                cmd.Parameters.AddWithValue("@gender", gender.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@marital_status", mstatus.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@household_no", houseno);
                cmd.Parameters.AddWithValue("@street", street);
                cmd.Parameters.AddWithValue("@zone", zone.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@bday", bday);
                cmd.Parameters.AddWithValue("@bplace", bplace);
                cmd.Parameters.AddWithValue("@religion", religion.SelectedValue); ;
                cmd.Parameters.AddWithValue("@occupation", occupation);
                cmd.ExecuteNonQuery();

                residentialList.EditIndex = -1;
                load_data();
            }


        }

        void religion_datarow(GridViewRowEventArgs e)
        {
            MySqlCommand ocmd = new MySqlCommand("SELECT * FROM religion", con);
            MySqlDataAdapter oda = new MySqlDataAdapter(ocmd);
            MySqlCommandBuilder builder = new MySqlCommandBuilder(oda);
            DataSet ds = new DataSet();
            oda.Fill(ds);

            DropDownList ddlreli = (DropDownList)e.Row.FindControl("DropDownList4");

            if (ddlreli != null)
            {
                ddlreli.DataSource = ds;
                ddlreli.DataValueField = "id";
                ddlreli.DataTextField = "religion_name";
                ddlreli.DataBind();
            }

           ((DropDownList)e.Row.FindControl("DropDownList4")).SelectedValue = DataBinder.Eval(e.Row.DataItem, "religion_id").ToString();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowType == DataControlRowType.DataRow) && ((e.Row.RowState & DataControlRowState.Edit) > 0))
            {
                religion_datarow(e);

            }


            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != residentialList.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
        }

        void cleartext()
        {
            lname.Text = "";
            fname.Text = "";
            mname.Text = "";
            house_num.Text = "";
            Street.Text = "";
            bplace.Text = "";
            occupation.Text = "";
            bday.Text = "";
            gender.Text = "--SELECT--";
            Marital_Status.Text = "--SELECT--";
            zone.Text = "--SELECT--";
            religion.SelectedItem.Text = "--SELECT--";
            bday.Text = "";
        }


        void add_resident()
        {
            //insert in residential table
            MySqlCommand cmd2 = new MySqlCommand("Insert INTO residential_list (fname,lname,mi,gender,marital_status,household_no,street,zone,bday,bplace,religion,occupation) VALUES (@fname,@lname,@mi,@gender,@marital_status,@household_no,@street,@zone,@bday,@bplace,@religion,@occupation) ", con);
            cmd2.Parameters.AddWithValue("@fname", fname.Text);
            cmd2.Parameters.AddWithValue("@lname", lname.Text);
            cmd2.Parameters.AddWithValue("@mi", mname.Text);
            cmd2.Parameters.AddWithValue("@gender", gender.SelectedValue);
            cmd2.Parameters.AddWithValue("@marital_status", Marital_Status.SelectedValue);
            cmd2.Parameters.AddWithValue("@household_no", house_num.Text);
            cmd2.Parameters.AddWithValue("@street", Street.Text);
            cmd2.Parameters.AddWithValue("@zone", zone.Text);
            cmd2.Parameters.AddWithValue("@bday", bday.Text);
            cmd2.Parameters.AddWithValue("@bplace", bplace.Text);
            cmd2.Parameters.AddWithValue("@religion", religion.SelectedValue);
            cmd2.Parameters.AddWithValue("@occupation", occupation.Text);
            cmd2.ExecuteNonQuery();

            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully added new residential.";
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
            cleartext();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //to check the existing record
            string qry = "select * from residential_list where fname=@fname and lname=@lname";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@fname", fname.Text);
            cmd.Parameters.AddWithValue("@lname", lname.Text);


            // MySqlDataReader sdr = cmd.ExecuteReader();
            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {

                Session["firstname"] = dt.Rows[0]["fname"].ToString();
                Session["lastname"] = dt.Rows[0]["lname"].ToString();

                if (fname.Text == Session["firstname"].ToString() && lname.Text == Session["lastname"].ToString())
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Firstname and lastname that you input is already exist in the system.";
                }

            }
            else
            {
                if (fname.Text == "" || lname.Text == "" || mname.Text == "" || house_num.Text == "" || Street.Text == "" || bplace.Text == "" || Marital_Status.SelectedValue == "--SELECT--" || occupation.Text == "" || gender.SelectedValue == "--SELECT--" || zone.SelectedValue == "--SELECT--" || religion.SelectedValue == "--SELECT--" || bday.Text == "")
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Missing details. Kindly complete it!";
                }
                else
                {
                    add_resident();
                    cleartext();
                    load_data();
                }
            }
        }

        Boolean ValidateRegisteredResidentials(int id)
        {
            string qry = "SELECT * FROM user where resi_id =@resi_id ";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@resi_id", id);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                return true;
            }
            else           
            {
                return false;
            }

        }
















    }
    
}