package com.mc.util;

public class EmailUtil {
    public static String htmlFormatter(String subject, String content, String email) {
        String htmlContent = """
            <html>
                <head>
                    <style>
                        table {
                          font-family: arial, sans-serif;
                          border-collapse: collapse;
                          width: 80%%;
                        }
                        td, th {
                              border: 1px solid #dddddd;
                              text-align: left;
                              padding: 8px;
                            }
                    </style>
                </head>
                <body>
                    <table>
                          <tr>
                            <td><strong>제목</strong></td>
                            <td>%s</td>
                          </tr>
                          <tr>
                            <td><strong>내용</strong></td>
                            <td>%s</td>
                          </tr>
                          <tr>
                            <td><strong>답변 받으실 연락처</strong></td>
                            <td>%s</td>
                          </tr>
                        </table>
                </body>
            </html>
            """;
        return String.format(htmlContent, subject, content, email);
    }
}
