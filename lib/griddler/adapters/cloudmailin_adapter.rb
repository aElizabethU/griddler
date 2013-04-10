module Griddler
  module Adapters
    class CloudmailinAdapter
      def initialize(params)
        @params = params
      end

      def self.normalize_params(params)
        adapter = new(params)
        adapter.normalize_params
      end

      def normalize_params
        {
          to: params[:envelope][:to],
          from: params[:envelope][:from],
          subject: params[:headers][:Subject],
          text: params[:plain],
          attachments: params.fetch(:attachments) { [] },
          in_reply_to: params["headers"]["In-Reply-To"],
          message_id: params["headers"]["Message-ID"],
        }
      end

      private

      attr_reader :params

    end
  end
end
