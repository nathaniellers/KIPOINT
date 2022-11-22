<%@ Page Title="Retrieve Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Retrieve.aspx.cs" Inherits="KIPOINT.Users.Retrieve" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card pb-3">
        <div class="container-fluid">
     

            <div class="card-card-header">

                <br />
                <br />
                <br />
        

                <asp:GridView ID="userList" runat="server" DataKeyNames="id" EmptyDataText="No records has been added." OnRowDeleting="OnRowDeleting" OnRowDataBound="OnRowDataBound"
                ShowHeaderWhenEmpty="True" Width="100%" Height="200px" HorizontalAlign="Center" AutoGenerateColumns="False" OnRowCommand="OnRowCommand" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
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
                                <asp:Label ID="lbl_username0" runat="server" Text='<%#Eval("user_type") %>' ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Retrieve" runat="server" CommandName="btn_Retrieve" Text="Retrieve" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirmation();"  ForeColor="White" BackColor="#009900" />
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                        <asp:CommandField ButtonType="Button" ShowDeleteButton="True" >
                       
                        <ControlStyle BackColor="#FF3300" ForeColor="White" />
                        </asp:CommandField>
                       
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

    <script type="text/javascript">
       function confirmation() {
           if (confirm('Are you sure you want to retrieve on this selected row?')) {
           return true;
           }else{
           return false;
           }
       }
    </script>

</asp:Content>
