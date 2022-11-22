<%@ Page Title="Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="KIPOINT.User.UserList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

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
                width: 1001px;
                height: 22px;
            }
            .auto-style2 {
                width: 671px;
                height: 22px;
            }
            .auto-style3 {
                width: 450px;
                height: 22px;
            }
            .auto-style4 {
                width: 318px;
                height: 22px;
            }   
        .nav-justified{
            margin-top: 50px;
        }
   
    
    </style>


    <div class="card pb-3">
        <div class="container-fluid">
         
            <div class="card-card-header">
             <table style="width: 100%; height: 130px">
                    <tr>
                        <td style="height: 22px; width: 1001px">&nbsp;</td>
                        <td style="width: 671px; height: 22px;">
                            &nbsp;</td>
                        <td style="height: 22px; width: 450px">
                            &nbsp;</td>
                        <td colspan="2" style="height: 22px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="height: 22px; width: 1001px">&nbsp;</td>
                        <td style="width: 671px; height: 22px;">
                            &nbsp;</td>
                        <td style="height: 22px; width: 450px">
                            &nbsp;</td>
                        <td colspan="2" style="height: 22px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="height: 22px; width: 1001px"></td>
                        <td style="width: 671px; height: 22px;">
                            Firsname</td>
                        <td style="height: 22px; width: 450px">
                            <asp:TextBox ID="TextBox1" runat="server" Height="25px" Width="200px"></asp:TextBox>
                        </td>
                        <td colspan="2" style="height: 22px"></td>
                    </tr>
                    <tr>
                        <td style="width: 1001px" class="modal-lg">&nbsp;</td>
                        <td style="width: 671px">Lastname</td>
                        <td style="width: 450px">
                            <asp:TextBox ID="TextBox2" runat="server" Height="25px" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 318px" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 1001px; height: 25px;">&nbsp;</td>
                        <td style="width: 671px; height: 25px;">MI</td>
                        <td style="width: 450px; height: 25px;">
                            <asp:TextBox ID="TextBox4" runat="server" Height="25px" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 318px; height: 25px;" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 1001px; height: 25px;"></td>
                        <td style="width: 671px; height: 25px;">Username</td>
                        <td style="width: 450px; height: 25px;">
                            <asp:TextBox ID="TextBox3" runat="server" Height="25px" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 318px; height: 25px;" colspan="2"></td>
                    </tr>
                    <tr>
                        <td class="auto-style1"></td>
                        <td class="auto-style2">
                            User type</td>
                        <td class="auto-style3">
                            <asp:DropDownList ID="DropDownList1" runat="server" Height="25px" Width="200px">
                                <asp:ListItem Value="Admin"></asp:ListItem>
                                <asp:ListItem Value="Staff"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td colspan="2" class="auto-style4"></td>
                    </tr>
                    <tr>
                        <td style="width: 1001px" class="modal-lg">
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                        </td>
                        <td style="width: 671px">
                            &nbsp;</td>
                        <td style="width: 450px">
                            &nbsp;</td>
                        <td style="width: 318px">
                            <asp:Button ID="Button1" runat="server" Text="ADD" Width="150px" OnClick="Button1_Click"  class="btn btn-success" />
                        </td>
                        <td style="width: 318px">
                            <asp:Button ID="Button2" runat="server" Text="Clear" Width="150px" OnClick="Button2_Click"  class="btn btn-danger" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 1001px" class="modal-lg">&nbsp;</td>
                        <td style="width: 671px">
                            &nbsp;</td>
                        <td style="width: 450px">
                            &nbsp;</td>
                        <td style="width: 318px" colspan="2">&nbsp;</td>
                    </tr>
                </table>
                <asp:GridView ID="userList" runat="server" DataKeyNames="id" OnRowDataBound="OnRowDataBound"
                OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="True"
                ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="100%" Height="200px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Lastname">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_lname" runat="server" Text='<% #Bind("lastname") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_lname" runat="server"  Text='<% #Eval("lastname") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Firstname">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_fname" runat="server" Text='<% #Bind("firstname") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_fname" runat="server" Text='<% #Eval("firstname") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Middlename">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_mname" runat="server" Text='<% #Bind("mi") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_mname" runat="server" Text='<% #Eval("mi") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Username">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_username" runat="server" Text='<% #Bind("username") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_username" runat="server" Text='<% #Eval("username") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User type">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddl_usertype" runat="server">
                                    <asp:ListItem Value="Admin"></asp:ListItem>
                                    <asp:ListItem Value="Staff"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_username" runat="server" Text='<%#Eval("user_type") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Top" BorderStyle="Solid" Wrap="True" Font-Bold="True" />
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
      
             
         
        </div>
   
    
  

   
</asp:Content>
