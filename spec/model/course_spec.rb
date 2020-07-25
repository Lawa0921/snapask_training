require 'rails_helper'

RSpec.describe "Course", type: :model do
  describe "model validation" do
    let(:course) { create(:course) }
    context "可正常建立" do
      it "when 正常填入" do 
        expect(course).to be_valid 
      end
    end
    context "建立失敗" do
      context "name 欄位" do
        it "when 未填 name" do
          course.name = ""
          expect(course).not_to be_valid
          expect(course.errors.full_messages).to include "#{I18n.t("activerecord.attributes.course.name")} #{I18n.t('errors.messages.blank')}"
        end
      end
      context "price 欄位" do
        it "when price 未填" do
          course.price = nil
          expect(course).not_to be_valid
          expect(course.errors.full_messages).to include "#{I18n.t("activerecord.attributes.course.price")} #{I18n.t('errors.messages.blank')}"
        end
      end
      context "currency 欄位" do
        it "when currency 未填" do
          course.currency = nil
          expect(course).not_to be_valid
          expect(course.errors.full_messages).to include "#{I18n.t("activerecord.attributes.course.currency")} #{I18n.t('errors.messages.blank')}"
        end
      end
      context "type_of_course 欄位" do
        it "type_of_course 未填" do
          course.type_of_course = nil
          expect(course).not_to be_valid
          expect(course.errors.full_messages).to include "#{I18n.t("activerecord.attributes.course.type_of_course")} #{I18n.t('errors.messages.blank')}"
        end
      end
      context "public 欄位" do
        it "public 未填" do
          course.public = nil
          expect(course).not_to be_valid
          expect(course.errors.full_messages).to include "#{I18n.t("activerecord.attributes.course.public")} #{I18n.t('errors.messages.blank')}"
        end
      end
      context "valididy_period 欄位" do
        it "valididy_period 未填" do
          course.valididy_period = nil
          expect(course).not_to be_valid
          expect(course.errors.full_messages).to include "#{I18n.t("activerecord.attributes.course.valididy_period")} #{I18n.t('errors.messages.blank')}"
        end
      end
    end
  end
end
