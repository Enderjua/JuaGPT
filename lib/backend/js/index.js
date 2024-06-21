const express = require('express');
const nodemailer = require('nodemailer');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

//json usage
app.use(bodyParser.json());

//mail 
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'mail',
    pass: 'password'
  }
});


app.post('/sendEmail', async (req, res) => {
  const { email, subject, text, name } = req.body;

  const mailOptions = {
    from: 'mail',
    to: email,
    subject: subject,
    html: `<div class=""><div class="aHl"></div><div id=":yl" tabindex="-1"></div><div id=":yv" class="ii gt" jslog="20277; u014N:xr6bB; 1:WyIjdGhyZWFkLWY6MTc3NDA0ODA5NzM0MDM5MTkyMCJd; 4:WyIjbXNnLWY6MTc3NDA0ODA5NzM0MDM5MTkyMCJd"><div id=":ye" class="a3s aiL msg5485456710295544655"><u></u>
    <div style="width:100%!important;min-height:100%!important;margin:0!important;padding:0!important;line-height:1.5;color:#1f2229;font-variant-ligatures:none;font-family:'Inter',Helvetica,Arial,sans-serif">
    <table class="m_5485456710295544655pc-project-body" style="table-layout:fixed;min-width:600px" width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
        <tbody><tr>
            <td align="center" valign="top">
                <table class="m_5485456710295544655pc-project-container" style="width:600px;max-width:600px" width="600" align="center" border="0" cellpadding="0" cellspacing="0" role="presentation">
                    <tbody><tr>
                        <td style="padding:0px" align="left" valign="top">
                            
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                <tbody><tr>
                                    <td style="padding:0px 0px 0px 0px">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                            <tbody><tr>
                                                
                                                <td valign="top" class="m_5485456710295544655pc-w520-padding-27-30-27-30 m_5485456710295544655pc-w620-padding-32-35-32-35" style="padding:40px 40px 20px 40px" bgcolor="#ffffff">
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    <table border="0" cellpadding="0" role="presentation" width="auto">
                                                        <tbody><tr>
                                                            <td valign="top" class="m_5485456710295544655pc-w620-fontSize-30 m_5485456710295544655pc-w620-lineHeight-40" style="font-family:'Inter',Helvetica,Arial,sans-serif;font-size:30px;line-height:36px;font-weight:700;color:#1f2229">
                                                                JuaGPT’de hesap oluşturmak için <span class="il">doğrulama</span> kodunuz</td>
                                                        </tr>
                                                    </tbody></table>
                                                    
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                            </tbody></table>
                            
    
                            
    <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
        <tbody><tr>
            <td style="padding:0px 0px 0px 0px">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                    <tbody><tr>
                        <td valign="top" class="m_5485456710295544655pc-w520-padding-30-30-30-30" style="padding:20px 40px 20px 40px;border-radius:0px;background-color:#ffffff" bgcolor="#ffffff">
    
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                <tbody><tr>
                                    <td style="padding:20px 0px 20px 0px" valign="top">
                                        <table border="0" cellpadding="0" role="presentation" width="auto">
                                            <tbody><tr>
                                                <td valign="top" class="m_5485456710295544655pc-w620-lineHeight-28" style="line-height:30px;letter-spacing:-0.2px;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:16px;line-height:24px;font-weight:normal;color:#4d525c">
                                                    Sayın ${name},
    
                                                    JuaGPT hesabınızın kurulumunu tamamlamak için <span class="il">e</span>-<span class="il">posta</span> adresinizi
                                                    <span class="il">doğrulama</span> kodunuz:
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                            </tbody></table>
    
                            
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                <tbody><tr>
                                    <td style="padding:0px 0px 0px 0px">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                            <tbody><tr>
                                                <td valign="top" class="m_5485456710295544655pc-w520-padding-30-30-30-30" style="padding:20px 0px 20px 0px;border-radius:0px;background-color:#ffffff" bgcolor="#ffffff">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation" style="background-color:#fafafa;border-radius:12px">
                                                        <tbody><tr>
                                                            <td style="padding:20px 0px 2px 0px" valign="top" align="center">
                                                                <table border="0" cellpadding="0" role="presentation" width="auto" align="center">
                                                                    <tbody><tr>
                                                                        <td valign="top" style="line-height:17px;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:14px;font-weight:600;color:#8fa63c;text-align:center;text-align:center" align="center">
                                                                            <span class="il">Doğrulama</span> kodunuz
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding:0px 0px 0px 0px" align="center">
                                                                <table width="auto" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                    <tbody><tr>
                                                                        <td valign="top" align="center" style="text-decoration:none;line-height:60px;letter-spacing:16px;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:40px;font-weight:600;color:#1f2229;text-align:center;text-align:center;padding:0px 0px 4px 0px">
                                                                            ${text}
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                            </tbody></table>
                            
                        </td>
                    </tr>
                </tbody></table>
            </td>
        </tr>
    </tbody></table>
    
    
                            
    
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                <tbody><tr>
                                    <td style="padding:0px 0px 0px 0px">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" role="presentation">
                                            <tbody><tr>
                                                <td valign="center" class="m_5485456710295544655pc-w520-padding-30-30-30-30 m_5485456710295544655pc-w620-padding-35-40-35-40" style="padding:40px 40px 40px 40px;border-radius:0px;background-color:#fafafa;border-radius:0px 0px 16px 16px" bgcolor="#fafafa">
                                                    
                                                    
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                        <tbody><tr>
                                                            <td valign="top">
                                                                <table border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                    <tbody><tr>
                                                                        <th valign="top" style="font-weight:normal;text-align:left">
                                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                <tbody><tr>
                                                                                    <td class="m_5485456710295544655pc-w620-spacing-0-10-0-0" style="padding:0px 20px 0px 0px" align="left">
                                                                                        <table width="auto" border="0" cellpadding="0" cellspacing="0" role="presentation">
                                                                                            <tbody><tr>
                                                                                                <td valign="top" align="left">
                                                                                                </td><td valign="top" style="padding:0px 20px 0px 0px;line-height:20px;letter-spacing:-0.2px;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:14px;font-weight:normal;color:#1f2229;opacity:0.6">
                                                                                                    JuaGPT,
                                                                                                    <a style="display:inline-block;color:#1f2229" href="mailto:support@schweis.eu" target="_blank">support@schweis.eu</a>
                                                                                                    ve
                                                                                                    <a style="display:inline-block;color:#1f2229" href="mailto:support2@schweis.eu" target="_blank">support2@schweis.eu</a>
                                                                                                    dışında farklı bir
                                                                                                    <span class="il">e</span>-<span class="il">posta</span> adresi üzerinden
                                                                                                    hesabınız veya
                                                                                                    işlemlerinizle ilgili
                                                                                                    bir <span class="il">e</span>-<span class="il">posta</span> göndermez;
                                                                                                    herhangi bir <span class="il">e</span>-postada
                                                                                                    şifrenizi talep etmez.
                                                                                                </td>
                                                                                                
                                                                                            </tr>
                                                                                        </tbody></table>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody></table>
                                                                        </th></tr></tbody></table></td>
                                                                    </tr>
    
                                                                </tbody></table>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
    
                                                    
                                                </td>
                                            </tr>
                                            <tr><td><table>
                                                <tbody><tr>
                                                    <td align="center" style="line-height:20px;letter-spacing:-0.2px;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:13px;font-weight:normal;color:#878d99;padding-top:24px">
                                                        Bu <span class="il">e</span>-<span class="il">posta</span> otomatik gönderilmiştir. Lütfen yanıtlamayın.
                                                    </td>
                                                </tr>
                                     
                                                <tr>
                                                    <td align="center" style="padding:0px 24px 0px 24px;line-height:20px;letter-spacing:-0.2px;font-family:'Inter',Helvetica,Arial,sans-serif;font-size:13px;font-weight:normal;color:#878d99;padding-top:16px">
                                                        JuaGPT © 2024 <a style="color:#878d99" href="https://www.schweis.eu" target="_blank" data-saferedirecturl="https://www.google.com/url?q=https://www.schweis.eu&amp;source=gmail&amp;ust=1717919156158000&amp;usg=AOvVaw3DWcG5M9eBCh2fBsREC9W-">Schweis.eu</a><br>
    
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </td></tr></tbody></table>
                                    </td>
                                </tr>
                            </tbody></table>
                            
                            <div class="m_5485456710295544655pc-gmail-fix" style="white-space:nowrap;font:15px courier;line-height:0">
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            </div>
    </td></tr></tbody></table></div><div class="yj6qo"></div><div class="adL">
    
    
    </div></div></div><div class="WhmR8e" data-hash="0"></div></div>`
  };

  try {
    await transporter.sendMail(mailOptions);
    res.status(200).send('Onay kodu gönderildi!');
  } catch (error) {
    console.error('Onay kodu gönderilemedi:', error);
    res.status(500).send('Onay kodu hatası:' + error.message);
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
