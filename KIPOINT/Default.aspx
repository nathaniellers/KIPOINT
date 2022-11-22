<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="KIPOINT._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        h1{
            text-align:center;
        }
    </style>


    <div class="jumbotron">
        <h1>&nbsp;Barangay Pinagsama Village</h1>
        <br />
        <br />
         <div id="calendar"></div>
        <br />
        <div class="modal-body">   

                   <div style="overflow-x: auto;">
                <asp:GridView ID="schedule_list" runat="server" DataKeyNames="id" EmptyDataText="No records has been added."
                    ShowHeaderWhenEmpty="True" Width="150%" Height="100px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" >
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

    </div>
  

 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">

    const eventArray = [];


    $(document).ready(function () {
        $.ajax({
            type: "POST",
            url: "Default.aspx/GetScheduleVenue",
            contentType: "application/json; charset=utf-8",
            data: "{}",
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
                console.log(eventArray);
                initCalender(eventArray);
            },
            failure: function (response) {
                console.log(response.d);
            },
            error: function (response) {
                console.log(response.d);
            }
        });
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
