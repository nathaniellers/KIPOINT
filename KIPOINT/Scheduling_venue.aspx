<%@ Page Title="Scheduling Venue" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scheduling_venue.aspx.cs" Inherits="KIPOINT.Scheduling_venue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        table {
            border-collapse: collapse;
            border-spacing: 0;
        }

        td,
        th {
            padding: 2px;
           
        }

        .auto-style9 {
            height: 22px;
        }

        .auto-style11 {
            width: 135px;
        }


        .auto-style13 {
            width: 80px;
        }

        .auto-style9 {
            height: 22px;
        }
        .auto-style11 {
           width: 135px;
        }


        .auto-style13 {
            width: 80px;
        }

        .auto-style14 {
            width: 168px;
        }

        .modal-body{        
            display:flex;      
            padding: 10px;
        }

        .modal-footer{
            padding: 10px;
        }

        .modal-content{
            margin-top: 20px;
        }
        .modal-header {
            padding: 5px;
        }

    </style>


    <div class="container-fluid">

        <div class="modal-content">

            <div id="calendar"></div>
            </div>
       

          <!-- Modal content -->
                  <div class="modal-content">
                    <div class="modal-header">                     
                      <h2>Schedule venue</h2>
                    </div>
                    <div class="modal-body">
                      <table align="center" class="auto-style2">
                        <tr>
                            <td class="auto-style14">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Venue Name*</td>
                            <td style="height: 22px">
                                <asp:DropDownList ID="ddl_venue" runat="server" Height="30px" Width="230px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Purpose*</td>
                            <td style="height: 22px">
                                <asp:TextBox ID="txt_purpose" runat="server" Height="55px" Width="230px" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Date start*</td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txt_datestart" runat="server" Height="30px" Width="230px" TextMode="Date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Date end*</td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txt_dateend" runat="server" Height="30px" Width="230px" TextMode="Date"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Time start*</td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txt_timestart" runat="server" Height="30px" Width="230px" TextMode="Time"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Time end*</td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txt_timeend" runat="server" Height="30px" Width="230px" TextMode="Time"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Reserved by*</td>
                            <td style="height: 22px">
                                <asp:DropDownList ID="ddl_reservedby" runat="server" Height="30px" Width="230px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                Remarks</td>
                            <td style="height: 22px">
                                <asp:TextBox ID="txt_remarks" runat="server" Height="73px" Width="230px" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style14">
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                            </td>
                            <td class="auto-style9">&nbsp;</td>
                        </tr>
                        </table>
                    </div>
   
                        <div class="modal-footer">    
                                <asp:Button ID="Button5" runat="server" Text="Submit" class="btn btn-success" OnClick="btn_add_Click"/>    
                                <asp:Button ID="Button6" runat="server" Text="Cancel" class="btn btn-danger" OnClick="btn_cancel_Click"/>                        
                        </div>
             </div>
      



  <div class="modal-content">
                 
      <asp:UpdatePanel ID="PanelScheduleVenue" runat="server" >
          <ContentTemplate>       
      <div class="modal-header">
            
                    <table align="left" class="nav-justified">
                        <tr>
                            <td class="auto-style11"><asp:DropDownList ID="Ddlist_Venue" runat="server" Height="30px" Width="200px"></asp:DropDownList></td>
                            <td class="auto-style13"><asp:Button ID="btn_search" runat="server" Text="Search" class="btn btn-primary" OnClick="btn_search_Click" /></td>
                            <td><asp:Button ID="btn_refresh" runat="server" Text="Refresh" class="btn btn-success" OnClick="btn_refresh_Click" /></td>
                        </tr>
                    </table>  
       </div>
    
 <div class="modal-body">   

                   <div style="overflow-x: auto;">
                <asp:GridView ID="schedule_list" runat="server" DataKeyNames="id" OnRowDataBound="OnRowDataBound"
                    OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                    OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added."
                    ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="150%" Height="100px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" >
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText ="REQ">
                        <ItemTemplate>
                        <asp:HyperLink ID="linl_req" runat="server" Text='<% #Eval("req") %>' NavigateUrl='<%# ("/SchduleVenueDetails.aspx") +"?id=" + Eval("id") %>' ></asp:HyperLink>
                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Venue Name">
                        <ItemTemplate>
                        <asp:Label ID="lbl_venue" runat="server" Text='<% #Eval("venue") %>'></asp:Label>
                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Purpose">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_purpose" runat="server" Text='<% #Bind("purpose") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_purpose" runat="server" Text='<% #Eval("purpose") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Capacity">
                            <ItemTemplate>
                                <asp:Label ID="lbl_capacity" runat="server" Text='<% #Eval("capacity") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date Start">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_date_start" runat="server" TextMode="Date" Text='<% #Bind("date_start") %>' Enabled="False"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_date_start" runat="server" Text='<% #Eval("date_start") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date End">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_date_end" runat="server" TextMode="Date" Text='<% #Bind("date_end") %>' Enabled="False"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_date_end" runat="server" Text='<% #Eval("date_end") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Time Start">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_start" runat="server" Text='<% #Bind("venue_start") %>' TextMode="Time" Enabled="False"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="txt_start" runat="server" Text='<% #Eval("v_start") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Time End">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_end" runat="server" Text='<% #Bind("venue_end") %>' TextMode="Time" Enabled="False"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_end" runat="server" Text='<% #Eval("v_end") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reserved by">
                            <ItemTemplate>
                                <asp:Label ID="lbl_reservedby" runat="server" Text='<% #Eval("reserved_by") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_remarks" runat="server" Text='<% #Bind("remarks") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_remarks" runat="server" Text='<% #Eval("remarks") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Event Status"></asp:TemplateField>
                        <asp:TemplateField HeaderText="Approval status">
                            <ItemTemplate>
                                <asp:Label ID="lbl_status" runat="server" Text='<% #Eval("status") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Process by">
                            <ItemTemplate>
                                <asp:Label ID="lbl_approved_by" runat="server" Text='<% #Eval("approved_by") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" ForeColor="White" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="True" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />   
                    </asp:GridView>          
                    <asp:Label ID="Label2" runat="server" Text=""/>
      

            </div>
        </div>
          </ContentTemplate>
              </asp:UpdatePanel>
    
        </div>
        </div>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

    
    function loadData(data) {
        
        let eventArray = [];
        $.ajax({
            type: "POST",
            url: "Scheduling_venue.aspx/GetScheduleVenuePerId",
            contentType: "application/json; charset=utf-8",
            data: "{ venue_id: '" + data + "'}",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (i, v) {
                    eventArray.push({
                        title: v.venue,
                        start: v.date_start + "T" + v.venue_start,
                        end: v.date_end + "T" + v.venue_end,
                        description: v.purpose,
                        status: v.status,
                        color: (v.status == "Pending" ? 'yellow' : (v.status == "Approved" ? 'green' : (v.status == "Cancel" ? 'red' : 'aqua'))),
                    })
                });
                console.log(data);
                console.log(eventArray);                
                initCalender(eventArray);
            },
            failure: function (response) {
                console.log(response.d)
            },
            error: function (response) {
                console.log(response.d)
            }
        });
    }

    $('select[name="ctl00$MainContent$ddl_venue"]').on('change', function () {
        //alert($(this).val());
        loadData($(this).val());  
    });

    $(document).ready(function () {
        loadData();
    });


    function initCalender(data) {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            navLinks: true,
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: (data)
        });

        calendar.render();


    }



    $(document).ready(function () {
        $('#logout').on('click', function () {
            Session.clear();
        })
    })

</script>


</asp:Content>



