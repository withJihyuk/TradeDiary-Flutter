package com.jihyuk.potatodiary

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class PotatoDiaryWidget : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val options = appWidgetManager.getAppWidgetOptions(widgetId)
            val minWidth = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH, 0)

            val views = if (minWidth >= 250) {
                createMediumLayout(context, widgetData)
            } else {
                createSmallLayout(context, widgetData)
            }

            val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java,
                Uri.parse("potatoDiary://write")
            )
            views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    private fun createSmallLayout(context: Context, widgetData: SharedPreferences): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.potato_diary_widget)

        val streak = widgetData.getInt("streak_count", 0)
        val currentLevel = widgetData.getInt("current_level", 1)
        val currentExp = widgetData.getInt("current_exp", 0)
        val nextLevelExp = widgetData.getInt("next_level_exp", 15)

        val streakText = if (streak > 0) "\uD83D\uDD25 ${streak}일 연속" else "오늘부터 시작!"
        views.setTextViewText(R.id.streak_text, streakText)
        views.setTextViewText(R.id.level_text, "LV.$currentLevel")

        val potatoResId = getPotatoResId(context, currentLevel)
        views.setImageViewResource(R.id.potato_image, potatoResId)

        val progress = if (nextLevelExp > 0) (currentExp * 100 / nextLevelExp) else 0
        views.setProgressBar(R.id.exp_progress, 100, progress, false)

        return views
    }

    private fun createMediumLayout(context: Context, widgetData: SharedPreferences): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.potato_diary_widget_medium)

        val streak = widgetData.getInt("streak_count", 0)
        val currentLevel = widgetData.getInt("current_level", 1)
        val currentExp = widgetData.getInt("current_exp", 0)
        val nextLevelExp = widgetData.getInt("next_level_exp", 15)
        val nickname = widgetData.getString("nickname", "") ?: ""
        val todayEmotion = widgetData.getString("today_emotion", "") ?: ""

        val streakText = if (streak > 0) "\uD83D\uDD25 ${streak}일 연속" else "오늘부터 시작!"
        views.setTextViewText(R.id.streak_text, streakText)
        views.setTextViewText(R.id.level_nickname_text, "LV.$currentLevel $nickname")

        val emotionText = if (todayEmotion.isNotEmpty()) "오늘: $todayEmotion" else "오늘 일기를 써봐요!"
        views.setTextViewText(R.id.emotion_text, emotionText)
        views.setTextViewText(R.id.exp_text, "$currentExp/$nextLevelExp")

        val potatoResId = getPotatoResId(context, currentLevel)
        views.setImageViewResource(R.id.potato_image, potatoResId)

        val progress = if (nextLevelExp > 0) (currentExp * 100 / nextLevelExp) else 0
        views.setProgressBar(R.id.exp_progress, 100, progress, false)

        return views
    }

    private fun getPotatoResId(context: Context, level: Int): Int {
        val safeLevel = level.coerceIn(1, 7)
        return context.resources.getIdentifier(
            "img_potato_${safeLevel}lv",
            "drawable",
            context.packageName
        )
    }
}
