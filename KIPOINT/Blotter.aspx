<%@ Page Title="Blotter" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Blotter.aspx.cs" Inherits="KIPOINT.Blotter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        table {
          border-collapse: collapse;
          border-spacing: 0;
            height: 22px;
            width: 179px;
        }
        .auto-style7 {
        }

        td,
        th {
            padding: 2px;
        }
        .auto-style1 {
            height: 22px;
            width: 164px;
        }
        .auto-style2 {
            width: 164px;
        }
        .auto-style4 {
            height: 31px;
            width: 164px;
        }
        .auto-style5 {
            height: 20px;
            width: 164px;
        }
        .auto-style6 {
            width: 179px;
        }
        .auto-style9 {
            height: 31px;
            width: 179px;
        }
        .auto-style10 {
            height: 20px;
            width: 179px;
        }
        .auto-style11 {
            width: 382px;
        }
        .auto-style12 {
            height: 31px;
        }
        .auto-style13 {
            width: 1328px;
        }
        .container-fluid {
            margin-top: 50px;
        }
    </style>

    <div class="container-fluid">

    
    <div class="container-fluid">

        <table align="center" class="nav-justified" style="padding: 2px">
            <tr>
                <td class="auto-style1">&nbsp;</td>
                <td style="width: 382px; height: 22px">
                    &nbsp;</td>
                <td class="auto-style6">&nbsp;</td>
                <td style="height: 22px" colspan="3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1">Complainant</td>
                <td style="width: 382px; height: 22px">
                    <asp:DropDownList ID="ddl_com1" runat="server" Height="25px" Width="200px">
                    </asp:DropDownList>
                </td>
                <td class="auto-style6">Contact #</td>
                <td style="height: 22px" colspan="3">
                    <asp:TextBox ID="txt_contact1" runat="server" Height="25px" Width="200px" MaxLength="12" TextMode="Phone"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Complainee</td>
                <td style="width: 382px">
                    <asp:DropDownList ID="ddl_com2" runat="server" Height="25px" Width="200px">
                    </asp:DropDownList>
                </td>
                <td class="auto-style7">Contact #</td>
                <td colspan="3">
                    <asp:TextBox ID="txt_contact2" runat="server" Height="25px" Width="200px" MaxLength="12" TextMode="Phone"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">Complaint</td>
                <td class="auto-style11" rowspan="3">
                    <asp:TextBox ID="txt_complaint" runat="server" Height="70px" Width="200px" TextMode="MultiLine"></asp:TextBox>
                </td>
                <td class="auto-style9">Incidence</td>
                <td colspan="3" class="auto-style12">
                    <asp:TextBox ID="txt_incidence" runat="server" Height="25px" Width="200px" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style10">Status</td>
                <td style="height: 20px" colspan="3">
                    <asp:DropDownList ID="ddl_status" runat="server" Height="25px" Width="200px">
                        <asp:ListItem Value="Active">Active</asp:ListItem>
                        <asp:ListItem Value="Settled"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style10">&nbsp;</td>
                <td style="height: 20px" colspan="3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </td>
                <td class="auto-style7">&nbsp;</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                <td>
                    <asp:Button ID="Button2" runat="server" Text="Add Blotter" Width="150px" OnClick="Button2_Click" Height="30px" class="btn btn-success"/>
                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Cancel" Width="150px" OnClick="Button1_Click" Height="30px"   class="btn btn-danger"/>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td style="width: 382px">&nbsp;</td>
                <td class="auto-style7">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>

    </div>

        
        <div style="overflow-x: auto">
         <asp:GridView ID="blotter_list" runat="server" DataKeyNames="id" OnRowDataBound="OnRowDataBound" 
                OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="True"
                ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="124%" Height="200px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
             <AlternatingRowStyle BackColor="#CCCCCC" />
             <Columns>
                 <asp:TemplateField HeaderText=" DateTime" >
                     <ItemTemplate>
                         <asp:Label ID="lbl_date" runat="server" Text='<% #Eval("date") %>' ></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Complainant" >
                     <EditItemTemplate>
                         <asp:DropDownList ID="ddl_complainant" runat="server" AutoPostBack="True">
                         </asp:DropDownList>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_complainant" runat="server" Text='<% #Eval("complainant") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Contact #" >
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_contact1" runat="server" Text='<% #Bind("contact1") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_contact1" runat="server" Text='<% #Eval("contact1") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Person to Complain" >
                     <EditItemTemplate>
                         <asp:DropDownList ID="ddl_complainee" runat="server">
                         </asp:DropDownList>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_complainee" runat="server" Text='<% #Eval("complainee") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Contact #" >
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_contact2" runat="server" Text='<% #Bind("contact2") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_contact2" runat="server" Text='<% #Eval("contact2") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Complaint" >
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_complaint" runat="server" TextMode="MultiLine" Text='<% #Bind("complaint") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_complaint" runat="server"  Text='<% #Eval("complaint") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Status" >
                     <EditItemTemplate>
                         <asp:DropDownList ID="ddl_status" runat="server" Text='<% #Bind("status") %>'>
                             <asp:ListItem Value="Active"></asp:ListItem>
                             <asp:ListItem Value="Settled"></asp:ListItem>
                         </asp:DropDownList>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_status" runat="server" Text='<% #Eval("status") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Incidence" >
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_incidence" runat="server" Text='<% #Bind("incidence") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_incidence" runat="server" Text='<% #Eval("incidence") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Assist by">
                     <ItemTemplate>
                         <asp:Label ID="txt_assistby" runat="server" Text='<% #Eval("assist_by") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
             </Columns>
             <FooterStyle BackColor="#CCCCCC" />
         <HeaderStyle BackColor="Black" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="True" />
             <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
         <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
             <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
             <SortedAscendingCellStyle BackColor="#F1F1F1" />
             <SortedAscendingHeaderStyle BackColor="#808080" />
             <SortedDescendingCellStyle BackColor="#CAC9C9" />
             <SortedDescendingHeaderStyle BackColor="#383838" />
         </asp:GridView>
    </div>


   

    </div>
</asp:Content>
