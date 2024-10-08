# Generated by Django 4.2.7 on 2024-05-04 06:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('App', '0002_postphoto_delete_click'),
    ]

    operations = [
        migrations.CreateModel(
            name='SolarDeviceData',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('device_id', models.IntegerField()),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('electricity', models.FloatField()),
                ('humidity', models.FloatField()),
                ('people_count', models.IntegerField()),
                ('is_sprinkling', models.BooleanField(default=False)),
            ],
        ),
    ]
