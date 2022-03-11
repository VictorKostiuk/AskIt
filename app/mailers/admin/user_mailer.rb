module Admin
  class UserMailer < ApplicationMailer
    def bulk_import_done
      @user = params[:user]

      mail to: @user.email, subject: "Users were successfully created"
    end

    def bulk_import_fail
      @user = params[:user]
      @error = params[:error]

      mail to: @user.email, subject: "Users were not created"
    end

    def bulk_export_done
      @user = params[:user]
      zipped_blob = params[:zipped_blob]

      attachments[zipped_blob.attachable_filename] = zipped_blob.download
      mail to: @user.email, subject: "Users were not created"
    end
  end
end