<%@ Page Title="Reservation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reservation.aspx.cs" Inherits="KIPOINT.Reservation" %>
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
            /*overflow-x: auto;*/
        }
        .modal-content {
           
            margin-top: 20px;
        }

        table {
            border-collapse: collapse;
            border-spacing: 0;
        }




        td,
        th {
            padding: 2px;
        }
        .auto-style6 {
            height: 22px;
            width: 179px;
        }
            .auto-style7 {
                width: 413px;
                height: 22px;
            }
            .auto-style9 {
                height: 22px;
            }
    .auto-style10 {
                width: 413px;
            }
            .auto-style12 {
                width: 183px;
            }
    </style>



    
     <div class="container-fluid">


         <div class="modal-content">
             <div class="jumbotron">
                 <div id="calendar"></div>
             </div>
         </div>
         
                   <div class="modal-content">
                    <div class="modal-header">                     
                    <h2>Reservation Equipment</h2>
                    </div>
                    <div class="modal-body">
                        <table align="center" class="nav-justified">
                            <tr>
                            <td class="auto-style10">&nbsp;</td>
                            <td class="auto-style12">&nbsp;</td>
                            <td class="auto-style6">
                                &nbsp;</td>
                            <td style="height: 22px" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                            <td class="auto-style10">&nbsp;</td>
                            <td class="auto-style12">Equipment Name*</td>
                            <td class="auto-style6">
                                <asp:DropDownList ID="ddl_equipment" runat="server" Height="25px" Width="200px">
                                </asp:DropDownList>
                                </td>
                            <td style="height: 22px" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                            <td class="auto-style10">&nbsp;</td>
                            <td class="auto-style12">Purpose*</td>
                            <td class="auto-style6">
                                <asp:TextBox ID="txt_purpose" runat="server" Height="89px" Width="200px" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            <td style="height: 22px" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                            <td class="auto-style7"></td>
                            <td class="auto-style12">Date start*</td>
                            <td class="auto-style6">
                                <asp:TextBox ID="txt_datestart" runat="server" Height="25px" Width="200px" TextMode="Date" ></asp:TextBox>
                                </td>
                            <td colspan="2" class="auto-style9">
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style7"></td>
                            <td class="auto-style12">Date end*</td>
                            <td class="auto-style6">
                                <asp:TextBox ID="txt_dateend" runat="server" Height="25px" Width="200px" TextMode="Date"></asp:TextBox>
                                </td>
                            <td colspan="2" class="auto-style9"></td>
                            </tr>
                            <tr>
                            <td class="auto-style7"></td>
                            <td class="auto-style12">Time start*</td>
                            <td class="auto-style6">
                                <asp:TextBox ID="txt_timestart" runat="server" Height="25px" Width="200px" TextMode="Time"></asp:TextBox>
                                </td>
                            <td colspan="2" class="auto-style9"></td>
                            </tr>
                            <tr>
                            <td class="auto-style7"></td>
                            <td class="auto-style12">Time end*</td>
                            <td class="auto-style6">
                                <asp:TextBox ID="txt_timeend" runat="server" Height="25px" Width="200px" TextMode="Time"></asp:TextBox>
                                </td>
                            <td colspan="2" class="auto-style9"></td>
                            </tr>
                            <tr>
                            <td class="auto-style10">&nbsp;</td>
                            <td class="auto-style12">Reserved by*</td>
                            <td class="auto-style6">
                                <asp:DropDownList ID="ddl_reservedby" runat="server" Height="25px" Width="200px">
                                </asp:DropDownList>
                                </td>
                            <td style="height: 22px" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                            <td class="auto-style10"></td>
                            <td class="auto-style12">Remarks</td>
                            <td class="auto-style13">
                                <asp:TextBox ID="txt_remarks" runat="server" Height="98px" Width="200px" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            <td colspan="2" class="auto-style14"></td>
                            </tr>
                            <tr>
                            <td class="auto-style7"></td>
                            <td class="auto-style12"></td>
                            <td class="auto-style6">
                                </td>
                            <td colspan="2" class="auto-style9"></td>
                            </tr>
                            <tr>
                            <td class="auto-style7">&nbsp;</td>
                            <td class="auto-style12">
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                </td>
                            <td class="auto-style6">
                                &nbsp;</td>
                            <td class="auto-style9">
                                
                                </td>
                            <td class="auto-style9">
                                
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style7">&nbsp;</td>
                            <td class="auto-style12"></td>
                            <td class="auto-style6">
                                </td>
                            <td colspan="2" class="auto-style9"></td>
                            </tr>
                            </table>

                        <div class="modal-footer">
                                <asp:Button ID="btn_add" runat="server" Height="30px" Text="Add" Width="200px" class="btn btn-success" OnClick="btn_add_Click" />
                                <asp:Button ID="btn_cancel" runat="server" Height="30px" Text="Cancel" Width="200px" class="btn btn-danger" OnClick="btn_cancel_Click" />
                        </div>
                  </div>
</div>
                


<div class="modal-content">
                 <asp:UpdatePanel ID="PanelScheduleVenue" runat="server" >
              <ContentTemplate>

                  <div class="modal-header">
  
                            <asp:DropDownList ID="DrpEquipment" runat="server" Height="30px" Width="200px"></asp:DropDownList>
                            <asp:Button ID="btn_search" runat="server" Text="Search" class="btn btn-primary" OnClick="btn_search_Click"/>
                            <asp:Button ID="btn_refresh" runat="server" Text="Refresh" class="btn btn-success" OnClick="btn_refresh_Click"/>          
                  </div>                   

<div class="modal-body">


           

         <div style="overflow-x: auto;">
       <asp:GridView ID="equipment_list" runat="server" DataKeyNames="id" OnRowDataBound="OnRowDataBound"
                    OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                    OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added."
                    ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="150%" Height="100px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" >
                     <AlternatingRowStyle BackColor="#CCCCCC" />
                     <Columns>
                   <asp:TemplateField HeaderText ="REQ">
                        <ItemTemplate>
                        <asp:HyperLink ID="linl_req" runat="server" Text='<% #Eval("eq_req") %>' NavigateUrl='<%# ("/ReservationViewREQ.aspx") +"?id=" + Eval("id") %>' ></asp:HyperLink>
                        </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="Equipment Name">
                     <ItemTemplate>
                         <asp:Label ID="lbl_eq_name" runat="server" Text='<% #Eval("eq_name") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Equipment No">
                     <ItemTemplate>
                         <asp:Label ID="lbl_eq_no" runat="server" Text='<% #Eval("eq_num") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Equipment Brand">
                     <ItemTemplate>
                         <asp:Label ID="lbl_eq_brand" runat="server" Text='<% #Eval("eq_brand") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Purpose">
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_purpose" runat="server" Text='<% #Bind("purpose") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_purpose" runat="server"  Text='<% #Eval("purpose") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Date Start">
                     <ItemTemplate>
                         <asp:Label ID="lbl_date_start" runat="server" Text='<% #Eval("date_start") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Date End">
                     <ItemTemplate>
                         <asp:Label ID="lbl_date_end" runat="server" Text='<% #Eval("date_end") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Time Start">
                     <ItemTemplate>
                         <asp:Label ID="txt_start" runat="server" Text='<% #Eval("t_start") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Time End">
                     <ItemTemplate>
                         <asp:Label ID="lbl_end" runat="server"  Text='<% #Eval("t_end") %>'></asp:Label>
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
                 <asp:TemplateField HeaderText="Status"></asp:TemplateField>
                 <asp:TemplateField HeaderText="Approval status">
                     <ItemTemplate>
                         <asp:Label ID="reservation_status" runat="server" Text='<% #Eval("status") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Approved by">
                     <ItemTemplate>
                         <asp:Label ID="lbl_approvedby" runat="server" Text='<% #Eval("approved_by") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
             </Columns>
             <FooterStyle BackColor="#CCCCCC" />
         <HeaderStyle BackColor="Black" ForeColor="White" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="True" />
             <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center"  />
         <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
             <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
             <SortedAscendingCellStyle BackColor="#F1F1F1" />
             <SortedAscendingHeaderStyle BackColor="#808080" />
             <SortedDescendingCellStyle BackColor="#CAC9C9" />
             <SortedDescendingHeaderStyle BackColor="#383838" />
         </asp:GridView>
                    <br />
                 
                    <asp:Label ID="Label2" runat="server" Text=""/>
              
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
            url: "Reservation.aspx/GetReservationId",
            contentType: "application/json; charset=utf-8",
            data: "{ eq_id: '" + data + "'}",
            dataType: "json",
            success: function (response) {
                $.each(response.d, function (i, v) {
                    eventArray.push({
                        title: v.venue,
                        start: v.date_start,
                        end: v.date_end,
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

    $('select[name="ctl00$MainContent$ddl_equipment"]').on('change', function () {
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
