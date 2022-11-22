<%@ Page Title="Position Lists" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Position_List.aspx.cs" Inherits="KIPOINT.Position_List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
         table {
          border-collapse: collapse;
          border-spacing: 0;
        }

        td,
        th {
            padding: 3px;
        }
        .auto-style1 {
            height: 22px;
            width: 164px;
        }
        .auto-style6 {
            height: 22px;
            width: 179px;
        }
        .auto-style7 {
        height: 22px;
        width: 432px;
    }
    .auto-style8 {
        width: 382px;
        height: 22px;
    }
    .auto-style9 {
        height: 22px;
    }
    .container-fluid {
        margin-top:50px;
    }
    
    </style>
    
    <div class="container-fluid">
   
       
            <table align="center" class="nav-justified" style="padding: 2px">
            <tr>
                <td class="auto-style1" style="width: 432px">&nbsp;</td>
                <td style="width: 382px; height: 22px">&nbsp;</td>
                <td class="auto-style6">&nbsp;</td>
                <td style="height: 22px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1" style="width: 432px">&nbsp;</td>
                <td style="width: 382px; height: 22px">Position*</td>
                <td class="auto-style6">
                    <asp:DropDownList ID="ddl_position" runat="server" Width="200px" Height="25px" OnSelectedIndexChanged="ddl_position_SelectedIndexChanged" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
                <td style="height: 22px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1" style="height: 22px; width: 432px;"></td>
                <td style="width: 382px; height: 22px">Lastname*</td>
                <td class="auto-style6" style="height: 22px">
                    <asp:TextBox ID="txt_lname" runat="server" Width="200px" Height="25px"></asp:TextBox>
                </td>
                <td style="height: 22px" colspan="2"></td>
            </tr>
            <tr>
                <td class="auto-style1" style="width: 432px">&nbsp;</td>
                <td style="width: 382px; height: 22px">Firsname*</td>
                <td class="auto-style6">
                    <asp:TextBox ID="txt_fname" runat="server" Width="200px" Height="25px"></asp:TextBox>
                </td>
                <td style="height: 22px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1" style="width: 432px">&nbsp;</td>
                <td style="width: 382px; height: 22px">Middlename</td>
                <td class="auto-style6">
                    <asp:TextBox ID="txt_mname" runat="server" Width="200px" Height="25px"></asp:TextBox>
                </td>
                <td style="height: 22px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1" style="width: 432px">&nbsp;</td>
                <td style="width: 382px; height: 22px">&nbsp;</td>
                <td class="auto-style6">
                    &nbsp;</td>
                <td style="height: 22px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style7"></td>
                <td class="auto-style8"></td>
                <td class="auto-style6"></td>
                <td class="auto-style9" colspan="2"></td>
            </tr>
            <tr>
                <td class="auto-style1" style="width: 432px">&nbsp;</td>
                <td class="auto-style9" colspan="2">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </td>
                <td style="height: 22px">
                    <asp:Button ID="btn_add" runat="server" Height="30px" OnClick="btn_add_Click" Text="Add Position" Width="150px" class="btn btn-success"/>
                </td>
                <td style="height: 22px">
                    <asp:Button ID="btn_cancel" runat="server" Height="30px" Text="Cancel" Width="150px" OnClick="btn_cancel_Click" class="btn btn-danger"/>
                </td>
            </tr>
            <tr>
                <td class="auto-style1" style="width: 432px">
                    <asp:Label ID="lbl_term" runat="server" Text="TERM: 0000-0000"></asp:Label>
                </td>
                <td style="width: 382px; height: 22px">&nbsp;</td>
                <td class="auto-style6">&nbsp;</td>
                <td style="height: 22px" colspan="2">&nbsp;</td>
            </tr>
                 </table>
   

        

         <asp:GridView ID="view_position" runat="server" DataKeyNames="id" OnRowDataBound="OnRowDataBound" 
                OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="True"
                ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="100%" Height="200px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" >
             <AlternatingRowStyle BackColor="#CCCCCC" />
             <Columns>
                 <asp:TemplateField HeaderText="Position">
                     <EditItemTemplate>
                         <asp:DropDownList ID="ddl_position" runat="server" ></asp:DropDownList>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_position" runat="server" Text='<% #Eval("pname") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Lastname">
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_lname" runat="server" Text='<% #Bind("lname") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_lname" runat="server" Text='<% #Eval("lname") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Firstname">
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_fname" runat="server" Text='<% #Bind("fname") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_fname" runat="server" Text='<% #Eval("fname") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Middlename">
                     <EditItemTemplate>
                         <asp:TextBox ID="txt_mname" runat="server" Text='<% #Bind("mname") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_mname" runat="server" Text='<% #Eval("mname") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Term Year">
                     <%--<EditItemTemplate>
                         <asp:DropDownList ID="ddl_term" runat="server" ></asp:DropDownList>
                     </EditItemTemplate>--%>
                     <ItemTemplate>
                         <asp:Label ID="lbl_termstart" runat="server"  Text='<% #Eval("term") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>

                 <asp:TemplateField HeaderText="Status">
                     <EditItemTemplate>
                         <asp:RadioButtonList ID="rb_status" runat="server">
                             <asp:ListItem Value="1">Active</asp:ListItem>
                             <asp:ListItem Value="0">Inactive</asp:ListItem>
                         </asp:RadioButtonList>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lbl_status" runat="server" Text='<% #Eval("status") %>'></asp:Label>
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
    

</asp:Content>
