<%@ Page Title="Manage Residentials" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Residential_List.aspx.cs" Inherits="KIPOINT.Resident_List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .card pb-3{
            margin-top: 50px;
        }
        .auto-style1 {
            width: 240px;
            height: 21px;
        }
        .auto-style2 {
            width: 308px;
            height: 21px;
        }
        .auto-style3 {
            width: 169px;
            height: 21px;
        }
        .auto-style4 {
            width: 152px;
            height: 21px;
        }
        .auto-style5 {
            height: 21px;
        }
    </style>
  
    <br />
    <div class="card pb-3">
        <div class="container-fluid">




            <div class="card-card-header">

                 <div class="container">
    <table align="center" class="nav-justified" style="height: 520px">
    <tr>
        <td style="height: 20px; width: 240px;"></td>
        <td style="height: 20px; width: 308px;"></td>
        <td style="height: 20px; width: 169px"></td>
        <td style="height: 20px; width: 152px"></td>
        <td style="height: 20px"></td>
    </tr>
    <tr>
        <td style="height: 20px; width: 240px;">&nbsp;</td>
        <td style="height: 20px; width: 308px;">
            &nbsp;</td>
        <td style="height: 20px; width: 169px">&nbsp;</td>
        <td style="height: 20px; width: 152px">
            &nbsp;</td>
        <td style="height: 20px">&nbsp;</td>
    </tr>
    <tr>
        <td style="height: 20px; width: 240px;">Lastname*</td>
        <td style="height: 20px; width: 308px;">
            <asp:TextBox ID="lname" runat="server" Width="170px"></asp:TextBox>
        </td>
        <td style="height: 20px; width: 169px">Household #*&nbsp;&nbsp;&nbsp;</td>
        <td style="height: 20px; width: 152px">
            <asp:TextBox ID="house_num" runat="server" TextMode="Number" Width="170px"></asp:TextBox>
        </td>
        <td style="height: 20px"></td>
    </tr>
    <tr>
        <td style="height: 20px; width: 240px;">&nbsp;</td>
        <td style="height: 20px; width: 308px;">&nbsp;</td>
        <td style="height: 20px; width: 169px">&nbsp;</td>
        <td style="height: 20px; width: 152px">&nbsp;</td>
        <td style="height: 20px">&nbsp;</td>
    </tr>
    <tr>
        <td style="height: 20px; width: 240px;">
            Firstname*</td>
        <td style="height: 20px; width: 308px;">
            <asp:TextBox ID="fname" runat="server" Width="170px"></asp:TextBox>
        </td>
        <td style="height: 20px; width: 169px">
            Street*</td>
        <td style="height: 20px; width: 152px">
            <asp:TextBox ID="Street" runat="server" Width="170px"></asp:TextBox>
        </td>
        <td style="height: 20px">
            </td>
    </tr>
    <tr>
        <td style="height: 20px; width: 240px;">
            &nbsp;</td>
        <td style="height: 20px; width: 308px;">
            &nbsp;</td>
        <td style="height: 20px; width: 169px">
            &nbsp;</td>
        <td style="height: 20px; width: 152px">
            &nbsp;</td>
        <td style="height: 20px">
            &nbsp;</td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            Middle name*</td>
        <td style="height: 21px; width: 308px;">
            <asp:TextBox ID="mname" runat="server" Width="170px"></asp:TextBox>
        </td>
        <td style="height: 21px; width: 169px">
            Zone*</td>
        <td style="height: 21px; width: 152px">
            <asp:DropDownList ID="zone" runat="server" Height="27px" Width="170px">
                <asp:ListItem Value="--SELECT--"></asp:ListItem>
                <asp:ListItem Value="3"></asp:ListItem>
                <asp:ListItem Value="4"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td style="height: 21px">
        </td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            &nbsp;</td>
        <td style="height: 21px; width: 308px;">
            &nbsp;</td>
        <td style="height: 21px; width: 169px">
            &nbsp;</td>
        <td style="height: 21px; width: 152px">
            &nbsp;</td>
        <td style="height: 21px">
            &nbsp;</td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            Gender*</td>
        <td style="height: 21px; width: 308px;">
            <asp:DropDownList ID="gender" runat="server" Height="30px" Width="130px">
                <asp:ListItem Value="--SELECT--"></asp:ListItem>
                <asp:ListItem Value="Male"></asp:ListItem>
                <asp:ListItem Value="Female"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td style="height: 21px; width: 169px">
            Religion*</td>
        <td style="height: 21px; width: 152px">
            <asp:DropDownList ID="religion" runat="server" Height="30px" Width="170px">
            </asp:DropDownList>
        </td>
        <td style="height: 21px">
            &nbsp;</td>
    </tr>
    <tr>
        <td style="height: 22px; width: 240px;">
        </td>
        <td style="height: 22px; width: 308px;">
        </td>
        <td style="height: 22px; width: 169px">
        </td>
        <td style="height: 22px; width: 152px">
        </td>
        <td style="height: 22px">
        </td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            Marital Status*</td>
        <td style="height: 21px; width: 308px;">
            <asp:DropDownList ID="Marital_Status" runat="server" Height="30px" Width="130px">
                <asp:ListItem Value="--SELECT--"></asp:ListItem>
                <asp:ListItem Value="Single"></asp:ListItem>
                <asp:ListItem Value="Married"></asp:ListItem>
                <asp:ListItem Value="Widowed"></asp:ListItem>
                <asp:ListItem Value="Separated"></asp:ListItem>
                <asp:ListItem Value="Divorced"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td style="height: 21px; width: 169px">
            Occupation*</td>
        <td style="height: 21px; width: 152px">
            <asp:TextBox ID="occupation" runat="server" Width="170px" ></asp:TextBox>
        </td>
        <td style="height: 21px">
        </td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            &nbsp;</td>
        <td style="height: 21px; width: 308px;">
            &nbsp;</td>
        <td style="height: 21px; width: 169px">
            &nbsp;</td>
        <td style="height: 21px; width: 152px">
            &nbsp;</td>
        <td style="height: 21px">
            &nbsp;</td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            Date of Birth*</td>
        <td style="height: 21px; width: 308px;">
            <asp:TextBox ID="bday" runat="server" TextMode="Date" Width="135px" onkeydown="txtOnKeyPress(this);" ></asp:TextBox>
            </td>
        <td style="height: 21px; width: 169px">
            Birthplace*</td>
        <td style="height: 21px; width: 152px">
            <asp:TextBox ID="bplace" runat="server" Width="170px"></asp:TextBox>
        </td>
        <td style="height: 21px">
            &nbsp;</td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            </td>
        <td style="height: 21px; width: 308px;">
            </td>
        <td style="height: 21px; width: 169px">
            </td>
        <td style="height: 21px; width: 152px">
            </td>
        <td style="height: 21px">
            </td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </td>
        <td style="height: 21px; width: 308px;">
            &nbsp;</td>
        <td style="height: 21px; width: 169px">
            &nbsp;</td>
        <td style="height: 21px; width: 152px">
            &nbsp;</td>
        <td style="height: 21px">
            &nbsp;</td>
    </tr>
    <tr>
        <td style="height: 21px; width: 240px;">
            </td>
        <td style="height: 21px; width: 308px;">
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" Width="200px"  class="btn btn-success"/>
        </td>
        <td style="height: 21px; width: 169px">
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click1" Text="Cancel" Width="200px" class="btn btn-danger" />
        </td>
        <td style="height: 21px; width: 152px">
            &nbsp;</td>
        <td style="height: 21px">
            </td>
    </tr>
    <tr>
        <td class="auto-style1">
            </td>
        <td class="auto-style2">
            </td>
        <td class="auto-style3">
            </td>
        <td class="auto-style4">
            </td>
        <td class="auto-style5">
            </td>
    </tr>
    </table>
        </div> 

                <br />
                <div style="overflow-x: auto">
                <asp:GridView ID="residentialList" runat="server" DataKeyNames="id" OnRowDataBound="OnRowDataBound" 
                OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowUpdating="OnRowUpdating"
                OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="True"
                ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="187%" Height="200px" HorizontalAlign="Center" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Lastname">
                             <ItemTemplate>
                                <asp:Label ID="lbl_lname" runat="server" Text='<% #Eval("lname") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<% #Bind("lname") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Firstname">
                            <ItemTemplate>
                                <asp:Label ID="lbl_fname" runat="server" Text='<% #Eval("fname") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<% #Bind("fname") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Middlename">
                            <ItemTemplate>
                                <asp:Label ID="lbl_mi" runat="server" Text='<% #Eval("mi") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<% #Bind("mi") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gender">
                            <ItemTemplate>
                                <asp:Label ID="lbl_gender" runat="server" Text='<% #Eval("gender") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" Text='<% #Bind("gender") %>'>
                                    <asp:ListItem Value="Male"></asp:ListItem>
                                    <asp:ListItem Value="Female"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Marital Status">
                            <ItemTemplate>
                                <asp:Label ID="lbl_mstatus" runat="server" Text='<% #Eval("marital_status") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" Text='<% #Bind("marital_status") %>'>
                                        <asp:ListItem Value="Single"></asp:ListItem>
                                        <asp:ListItem Value="Married"></asp:ListItem>
                                        <asp:ListItem Value="Widowed"></asp:ListItem>
                                        <asp:ListItem Value="Separated"></asp:ListItem>
                                        <asp:ListItem Value="Divorced"></asp:ListItem>
                                    </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="House no">
                            <ItemTemplate>
                                <asp:Label ID="lbl_household_no" runat="server" Text='<% #Eval("household_no") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<% #Bind("household_no") %>' ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Street">
                            <ItemTemplate>
                                <asp:Label ID="lbl_street" runat="server" Text='<% #Eval("street") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<% #Bind("street") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Zone">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList3" runat="server" Text='<% #Eval("zone") %>' >
                                    <asp:ListItem Value="3"></asp:ListItem>
                                    <asp:ListItem Value="4"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_zone" runat="server" Text='<% #Eval("zone") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                         
                        <asp:TemplateField HeaderText="Birthday">
                            <ItemTemplate>
                                <asp:Label ID="lbl_bday" runat="server" Text='<% #Eval("bday") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" DataFormatString = "{0:MM/dd/yyyy}" TextMode="Date" Text='<% #Bind("bday") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Birthplace">
                             <ItemTemplate>
                                <asp:Label ID="lbl_bplace" runat="server" Text='<% #Eval("bplace") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<% #Bind("bplace") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Religion">
                            <ItemTemplate>
                                <asp:Label ID="lbl_religion" runat="server" Text='<% #Eval("religion") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" >
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Occupation">
                            <ItemTemplate>
                                <asp:Label ID="lbl_occupation" runat="server" Text='<% #Eval("occupation") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<% #Bind("occupation") %>' ></asp:TextBox>
                            </EditItemTemplate>
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
    </div>




</asp:Content>
