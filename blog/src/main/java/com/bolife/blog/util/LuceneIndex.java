package com.bolife.blog.util;

import com.bolife.blog.entity.Article;
import com.bolife.blog.entity.User;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.springframework.util.StringUtils;

import java.io.StringReader;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;

/**
 * 博客索引类
 * @author Administrator
 *
 */
public class LuceneIndex {

    private static Directory dir=null;
    private static String PATH = "D:\\226\\data";
//    private static String PATH = "/usr/local/data";

    /**
     * 获取IndexWriter实例
     * @return
     * @throws Exception
     */
    private static IndexWriter getWriter()throws Exception{
        /**
         * 生成的索引我放在了C盘，可以根据自己的需要放在具体位置
         */
        dir= FSDirectory.open(Paths.get(PATH));
        SmartChineseAnalyzer analyzer=new SmartChineseAnalyzer();
        IndexWriterConfig iwc=new IndexWriterConfig(analyzer);
        IndexWriter writer=new IndexWriter(dir, iwc);
        return writer;
    }

    /**
     * 添加博客索引
     * @param article
     */
    public static void addIndex(Article article)throws Exception{
        IndexWriter writer=getWriter();
        Document doc=new Document();
        doc.add(new StringField("id",String.valueOf(article.getArticleId()), Field.Store.YES));
        /**
         * yes是会将数据存进索引，如果查询结果中需要将记录显示出来就要存进去，如果查询结果
         * 只是显示标题之类的就可以不用存，而且内容过长不建议存进去
         * 使用TextField类是可以用于查询的。
         */
        doc.add(new TextField("articleTitle", article.getArticleTitle(), Field.Store.YES));
        doc.add(new TextField("articleContent",article.getArticleContent(), Field.Store.YES));
        writer.addDocument(doc);
        writer.close();
    }

    /**
     * 更新博客索引
     * @param article
     * @throws Exception
     */
    public static void updateIndex(Article article)throws Exception{
        IndexWriter writer=getWriter();
        Document doc=new Document();
        doc.add(new StringField("id",String.valueOf(article.getArticleId()), Field.Store.YES));
        /**
         * yes是会将数据存进索引，如果查询结果中需要将记录显示出来就要存进去，如果查询结果
         * 只是显示标题之类的就可以不用存，而且内容过长不建议存进去
         * 使用TextField类是可以用于查询的。
         */
        doc.add(new TextField("articleTitle", article.getArticleTitle(), Field.Store.YES));
        doc.add(new TextField("articleContent",article.getArticleContent(), Field.Store.YES));
        writer.updateDocument(new Term("id", String.valueOf(article.getArticleId())), doc);
        writer.close();
    }

    /**
     * 删除指定博客的索引
     * @param articleId
     * @throws Exception
     */
    public static void deleteIndex(String articleId)throws Exception{
        IndexWriter writer=getWriter();
        writer.deleteDocuments(new Term("id", articleId));
        writer.forceMergeDeletes(); // 强制删除
        writer.commit();
        writer.close();
    }

    /**
     * 查询博客
     * @param q 查询关键字
     * @return
     * @throws Exception
     */
    public static List<Article> searchBlog(String q)throws Exception{
        /**
         * 注意的是查询索引的位置得是存放索引的位置，不然会找不到。
         */
        dir= FSDirectory.open(Paths.get(PATH));
        IndexReader reader = DirectoryReader.open(dir);
        IndexSearcher is=new IndexSearcher(reader);
        BooleanQuery.Builder booleanQuery = new BooleanQuery.Builder();
        SmartChineseAnalyzer analyzer=new SmartChineseAnalyzer();
        /**
         * articleTitle和articleContent就是我们需要进行查找的两个字段
         * 同时在存放索引的时候要使用TextField类进行存放。
         */
        QueryParser parser=new QueryParser("articleTitle",analyzer);
        Query query=parser.parse(q);
        QueryParser parser2=new QueryParser("articleContent",analyzer);
        Query query2=parser2.parse(q);
        booleanQuery.add(query, BooleanClause.Occur.SHOULD);
        booleanQuery.add(query2, BooleanClause.Occur.SHOULD);
        TopDocs hits=is.search(booleanQuery.build(), 100);
        QueryScorer scorer=new QueryScorer(query);
        Fragmenter fragmenter = new SimpleSpanFragmenter(scorer);
        /**
         * 这里可以根据自己的需要来自定义查找关键字高亮时的样式。
         */
        SimpleHTMLFormatter simpleHTMLFormatter=new SimpleHTMLFormatter("<b><font style='color:#6bc30d;'>","</font></b>");
        Highlighter highlighter=new Highlighter(simpleHTMLFormatter, scorer);
        highlighter.setTextFragmenter(fragmenter);
        List<Article> articleList=new LinkedList<Article>();
        for(ScoreDoc scoreDoc:hits.scoreDocs){
            Document doc=is.doc(scoreDoc.doc);
            Article article = new Article();
            article.setArticleId(Integer.parseInt(doc.get(("id"))));
            article.setArticleContent(doc.get(("articleContent")));
            String username=doc.get("articleTitle");
            String description=doc.get("articleContent");
            if(username!=null){
                TokenStream tokenStream = analyzer.tokenStream("articleTitle", new StringReader(username));
                String husername=highlighter.getBestFragment(tokenStream, username);
                if(StringUtils.isEmpty(husername)){
                    article.setArticleTitle(username);
                }else{
                    article.setArticleTitle(husername);
                }
            }
            if(description!=null){
                TokenStream tokenStream = analyzer.tokenStream("articleContent", new StringReader(description));
                String hContent=highlighter.getBestFragment(tokenStream, description);
                if(StringUtils.isEmpty(hContent)){
                    if(description.length()<=200){
                        article.setArticleContent(description);
                    }else{
                        article.setArticleContent(description.substring(0, 200));
                    }
                }else{
                    article.setArticleContent(hContent);
                }
            }
            if(articleList.contains(article)){
                articleList.remove(article);
                articleList.add(article);
            }else {
                articleList.add(article);
            }
        }
        return articleList;
    }
}
