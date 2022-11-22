<%@ Page Title="Schedule Venue" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RequestScheduleVenue.aspx.cs" Inherits="KIPOINT.User.Residential.RequestScheduleVenue" %>
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
        .modal-header {
            padding: 10px;
        }
        .modal-footer {
            padding: 10px;
        }

        .modal-body {
            padding: 10px;
        }
        .modal-content {
            margin-bottom: 20px;
            
        }
        .auto-style1 {
            width: 535px;
        }
        .auto-style2 {
            width: 668px;
        }
        .auto-style3 {
            width: 208px;
        }
        .auto-style4 {
            width: 80px;
        }

        .auto-style5 {
            height: 22px;
            width: 407px;
        }
        .auto-style6 {
            width: 407px;
        }
        #msg {
            -webkit-animation: cssAnimation 5s forwards; 
            animation: cssAnimation 5s forwards;
        }
        @keyframes cssAnimation {
            0%   {opacity: 1;}
            90%  {opacity: 1;}
            100% {opacity: 0;}
        }
        @-webkit-keyframes cssAnimation {
            0%   {opacity: 1;}
            90%  {opacity: 1;}
            100% {opacity: 0;}
        }



    </style>
     

     <div class="card pb-3">
     <div class="container-fluid">
         
         <div class="modal-content">
             <div class="jumbotron">
                 <div id="calendar"></div>
             </div>
         </div>
         
                   <div class="modal-content">
                    <div class="modal-header">                     
                    <h2>Schedule Venue</h2>
                    </div>
                    <div class="modal-body">
                        
                          <table align="center" class="auto-style2">
                            <tr>
                                <td class="auto-style1">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Venue Name*</td>
                                <td class="auto-style5">
                                    <asp:DropDownList ID="ddl_venue" runat="server" Height="25px" Width="200px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Purpose*</td>
                                <td class="auto-style5">
                                    <asp:TextBox ID="txt_purpose" runat="server" Height="84px" Width="200px" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Date start*</td>
                                <td class="auto-style6">
                                    <asp:TextBox ID="txt_datestart" runat="server" Height="25px" Width="200px" TextMode="Date"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Date end*</td>
                                <td class="auto-style6">
                                    <asp:TextBox ID="txt_dateend" runat="server" Height="25px" Width="200px" TextMode="Date"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Time start*</td>
                                <td class="auto-style6">
                                    <asp:TextBox ID="txt_timestart" runat="server" Height="25px" Width="200px" TextMode="Time"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Time end*</td>
                                <td class="auto-style6">
                                    <asp:TextBox ID="txt_timeend" runat="server" Height="25px" Width="200px" TextMode="Time"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    Remarks</td>
                                <td class="auto-style5">
                                    <asp:TextBox ID="txt_remarks" runat="server" Height="25px" Width="200px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">
                                    &nbsp;</td>
                                <td class="auto-style5">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            </table>
                        <div class="modal-footer">
                                <asp:Button ID="btn_add" runat="server" Text="Submit" class="btn btn-success" OnClick="btn_add_Click" />                    
                                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" class="btn btn-danger" OnClick="btn_cancel_Click"/>             
                        </div>
                        </div>
                       </div>
         
                           
     
       <asp:UpdatePanel ID="PanelScheduleVenue" runat="server" >
              <ContentTemplate>

  <div class="modal-content">
                    <div class="modal-header">    

          

                    <table align="left" class="nav-justified">
                        <tr>
                            <td class="auto-style3"><asp:DropDownList ID="Ddlist_Venue" runat="server" Height="30px" Width="200px"></asp:DropDownList></td>
                            <td class="auto-style4"><asp:Button ID="btn_search" runat="server" Text="Search" class="btn btn-primary" OnClick="btn_search_Click"/></td>
                            <td><asp:Button ID="btn_refresh" runat="server" Text="Refresh" class="btn btn-success" OnClick="btn_refresh_Click"/></td>
                        </tr>
                    </table>                       
</div>


<div class="modal-body">
                  <div style="overflow-x: auto;">
                <asp:GridView ID="schedule_list" runat="server" DataKeyNames="id" OnRowDataBound="OnRowDataBound"
                    OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                    OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added."
                    ShowHeaderWhenEmpty="True" Width="120%" Height="100px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" >
                    <Columns>
                        <asp:TemplateField HeaderText ="REQ">
                        <ItemTemplate>
                        <asp:HyperLink ID="linl_req" runat="server" Text='<% #Eval("req") %>' NavigateUrl='<%# ("/User/Residential/ViewReqestSchedule.aspx") +"?id=" + Eval("id") %>' ></asp:HyperLink>
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
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <HeaderStyle BackColor="#333333" ForeColor="White" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="True" />
                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />   
                </asp:GridView>
                    <br />
                 
                    <asp:Label ID="msg" runat="server" Text=""/>

                      </div>
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
            url: "RequestScheduleVenue.aspx/GetScheduleVenuePerId",
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
